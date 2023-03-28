# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  city                   :string
#  date_of_birth          :date
#  due_date               :date
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  gender                 :string
#  grade                  :integer
#  health                 :string
#  id_no                  :string           default(""), not null
#  languages_spoken       :string
#  last_name              :string           default(""), not null
#  parent_occupation      :string
#  phone                  :string
#  phone2                 :string
#  physical               :string
#  position               :string
#  previous_owing         :decimal(8, 2)    default(0.0)
#  religion               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("Student")
#  room                   :string
#  start_date             :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  login_id               :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_login_id              (login_id) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#
class User < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, against: [:first_name, :last_name],
                           using: {
                             tsearch: { prefix: true },
                           }

  before_validation :set_temp_password, :set_login_id, :generate_email
  before_save :downcase_email
  before_save :normalize_phone

  before_validation do
    self.position = position.titleize unless position.nil?
    self.first_name = first_name.strip.titleize unless first_name.nil?
    self.last_name = last_name.strip.titleize unless last_name.nil?
    self.gender = gender.strip.capitalize unless gender.nil?
    self.health = "fit" if health.nil?
    self.physical = "fit" if physical.nil?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login_id]

  has_one_attached :avatar
  has_many :owned_notifications, class_name: "Notification"
  has_and_belongs_to_many :notifications
  has_many :private_threads1, class_name: "PrivateThread", foreign_key: "user1_id"
  has_many :private_threads2, class_name: "PrivateThread", foreign_key: "user2_id"
  has_and_belongs_to_many :messages
  has_many :assignment_answers
  has_many :question_answers
  has_many :payments, dependent: :destroy

  has_many :student_attendances
  has_one :student_parent, foreign_key: :student_id, dependent: :destroy
  has_one :parent_student, class_name: "StudentParent", foreign_key: :parent_id
  has_one :parent, through: :student_parent
  has_one :student, through: :parent_student
  has_many :teaching_subjects, class_name: "ClassroomSubject", foreign_key: "teacher_id"
  has_many :classrooms, foreign_key: "teacher_id"
  has_many :results, foreign_key: "student_id"

  enum role: {
         "Student": 0,
         "Teacher": 1,
         "Admin": 2,
         "Parent": 3,
         "SDC Member": 4,
       }

  enum grade: Grades::GRADES_HASH

  GENDER_TYPES = [
    MALE = "Male",
    FEMALE = "Female",
  ].freeze

  HEALTH_TYPES = %w(fit unfit).freeze
  PHYSICAL_TYPES = %w(fit unfit).freeze

  validates :first_name, :last_name, :city, presence: true
  validates :id_no, presence: true, length: { minimum: 4 }
  validates :address, presence: true, on: :update
  validates :role, inclusion: { in: roles.keys }
  validates :grade, inclusion: { in: grades.keys }
  validates :room, inclusion: { in: Rooms::TYPES }
  validates :health, inclusion: { in: HEALTH_TYPES }
  validates :physical, inclusion: { in: PHYSICAL_TYPES }
  validates :gender, inclusion: { in: GENDER_TYPES }
  validates :login_id, :id_no, uniqueness: true
  validates :phone, :phone2, phone: true, allow_blank: true

  scope :male_teachers, -> { teachers.where(:gender => "Male") }
  scope :boys, -> { students.where(:gender => "Male") }
  scope :girls, -> { students.where(:gender => "Female") }
  scope :female_teachers, -> { teachers.where(:gender => "Female") }
  scope :students, -> { where(:role => "Student") }
  scope :teachers, -> { where(:role => "Teacher") }
  scope :admins, -> { where(:role => "Admin") }
  scope :parents, -> { where(:role => "Parent") }

  def formatted_phone
    parsed_phone = Phonelib.parse(phone)
    return phone if parsed_phone.invalid?
    parsed_phone.full_international
  end

  def teacher_account
    classroom&.teacher
  end

  def total_paid
    sch_payment = SchoolPayment.current
    payments.where(term: sch_payment.term, year: sch_payment.year, accepted: true).sum(&:amount)
  end

  def current_balance
    (previous_owing || 0) + SchoolPayment.total_this_term - total_paid
  end

  def private_threads
    PrivateThread.where(id: [private_threads1.ids]).or PrivateThread.where(id: [private_threads2.ids])
  end

  def chat_people
    private_threads.map { |t| t.other_user(self) }
  end

  def unread_notifications
    base_query = case role
      when "Student"
        Notification.students_only
      when "Parent"
        Notification.parents_only
      when "Teacher"
        Notification.teachers_only
      when "Admin"
        Notification
      when "SDC Member"
        Notification.sdc_members_only
      end
    base_query.where.not(id: [notifications.pluck(:id)])
  end

  def unread_messages
    Message.where(threadable_type: "PrivateThread", threadable_id: [private_threads.ids]).where.not(id: [messages.pluck(:id)]).order(created_at: :desc)
  end

  def recent_messages
    all_messages = Message.where(threadable_type: "PrivateThread", threadable_id: [private_threads.ids]).where.not(user_id: id)
    threads = Message.select(:threadable_id).distinct.from(all_messages).group(:threadable_id)
    messages = []
    threads.each do |thr|
      messages << Message.where(threadable_id: [threads.map(&:threadable_id)], threadable_type: "PrivateThread").where.not(user_id: id).last
    end
    messages
  end

  def classroom_name
    if teacher?
      clsrm = Classroom.where(teacher: self).first
      return "#{clsrm.grade} #{clsrm.room}" if clsrm
    else
      "#{grade} #{room}" unless admin?
    end
  end

  def admin?
    role == "Admin"
  end

  def student?
    role == "Student"
  end

  def teacher?
    role == "Teacher"
  end

  def parent?
    role == "Parent"
  end

  def students
    if teacher?
      return classroom.students
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    "#{first_name.slice(0).upcase}. #{last_name.capitalize}"
  end

  def generate_email
    unless email
      self.email = login_id + "@impali.domain"
    end
  end

  def avatar_path
    if avatar.attached?
      if errors.any?
        u = User.find id
        u.avatar_path
      else
        Rails.application.routes.url_helpers.rails_representation_url(
          avatar.variant(resize_to_limit: [300, 300]).processed, only_path: true,
        )
      end
    else
      return "user.png"
    end
  end

  def classroom
    return nil if admin?
    Classroom.where(grade: grade, room: room).first
  end

  def subjects
    return nil if admin?
    classroom&.subjects
  end

  def classroom_subject(sub)
    classroom&.classroom_subjects.where(subject_id: sub.id).first
  end

  def classroom_subjects
    if parent?
      student.classroom&.classroom_subjects
    elsif teacher?
      result = teaching_subjects.select do |tsub|
        ClassroomSubject.where(id: tsub.id, subject_id: [tsub&.classroom&.subject_ids]).any?
      end
      ids = (result + (classroom&.classroom_subjects || [])).uniq.map(&:id)
      ClassroomSubject.where(id: [ids])
    else
      classroom&.classroom_subjects
    end
  end

  def recent_topics
    Topic.where(classroom_subject: [classroom_subjects&.pluck(:id)]).order(created_at: :desc)
  end

  def recent_lessons(count = 3)
    Lesson.where(topic_id: [recent_topics&.pluck(:id)]).order(created_at: :desc).take count
  end

  def recent_assignments(count = 3)
    Assignment.where(classroom_subject: [classroom_subjects&.pluck(:id)]).order(created_at: :desc).take count
  end

  class << self
    def payment_stats
      sch_payment = SchoolPayment.current
      if sch_payment
        user_ids = Payment.where(term: sch_payment.term, year: sch_payment.year, accepted: true).group(:user_id).count.keys
        not_paid = User.students.count - user_ids.length
        paid = Payment.where(user_id: [user_ids], term: sch_payment.term, year: sch_payment.year)
          .group(:user_id).sum(:amount).select { |k, v| v >= sch_payment.levy + sch_payment.tution }.keys.length
        owing = user_ids.length - paid
      else
        paid, owing, not_paid = 0, 0, User.students.count
      end
      { "Fully Paid" => paid, "Paid Partially" => owing, "Not Paid" => not_paid }
    end

    def next_grade_for_student(student)
      return "None" if student.grade == "Grade 7"
      index = Grades::GRADES_HASH.keys.index student.grade
      return Grades::GRADES_HASH.keys[index + 1]
    end

    def prev_grade_for_student(student)
      return "None" if student.grade == "ECD A"
      index = Grades::GRADES_HASH.keys.index student.grade
      return Grades::GRADES_HASH.keys[index - 1]
    end

    def query_students_grades
      students_grade = User.students
        .select("grade", "COUNT(*) as total")
        .group("grade").to_a
      json = JSON.parse students_grade.to_json
      result = json.map do |i|
        i.delete("id")
        i
      end
      result
    end
  end

  def payment_status
    return nil unless student?
    if current_balance <= 0
      return "Paid"
    elsif total_paid > 0
      return "Paid Partially"
    else
      return "Not Paid"
    end
  end

  def payment_tag
    if current_balance <= 0
      return "success"
    elsif total_paid > 0
      return "secondary"
    else
      return "danger"
    end
  end

  def attendance
    student_attendances.find_by(date: Date.today)
  end

  def teacher
    return nil unless student?
    classroom&.teacher
  end

  def can_access_lessons?
    return true if teacher?
    if due_date && (due_date > Date.today)
      return true
    end
    pardoned = false
    if student?
      pardoned = !!due_date
    elsif parent?
      pardoned = !!student.due_date
    end
    if (student? && current_balance > 0) && !pardoned
      return false
    elsif (parent? && student.current_balance > 0) && !pardoned
      return false
    end
    true
  end

  def total_marks_for(type, year = Date.today.year, term = SchoolTerm.get)
    actual = results.where(year: year, term: term, for: type).sum(&:actual_mark)
    total = results.where(year: year, term: term, for: type).sum(&:total_marks)
    [actual, total]
  end

  def class_position(year = Date.today.year, term = SchoolTerm.get)
    pos_index = classroom.sorted_marks(year, term).find_index { |x| x.last == id }
    return nil if results.where(term: term, year: year).empty?
    pos_index.nil? ? nil : pos_index + 1
  end

  def average_exam_mark(year = Date.today.year, term = SchoolTerm.get)
    m = total_marks_for "Exam", year, term
    100 * m.first.to_f / m.last
  end

  private

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end

  def set_login_id
    unless login_id
      self.login_id = rand_id
      if User.where(login_id: self.login_id).first
        set_login_id
      end
    end
  end

  def set_temp_password
    self.password = id_no if encrypted_password.blank?
  end

  def downcase_email
    self.email&.downcase!
  end

  def rand_letter
    ("A".."Z").to_a.sample
  end

  def rand_id
    rand_letter + rand(1_000..9_999).to_s + rand_letter
  end
end
