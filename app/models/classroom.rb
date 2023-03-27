# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  grade      :integer
#  room       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
class Classroom < ApplicationRecord
  belongs_to :teacher, class_name: "User", optional: true
  has_and_belongs_to_many :subjects
  has_many :messages, as: :threadable

  before_save :sync_subject_teachers
  after_save :sync_subjects, :sync_teacher

  validates :room, inclusion: { in: Rooms::TYPES }

  enum grade: Grades::GRADES_HASH

  validates :grade, inclusion: { in: grades.keys }
  validates :room, uniqueness: { case_sensitive: false, scope: :grade }
  # validates_uniqueness_of :teacher_id, if: -> { !teacher.nil? }

  def teacher_name
    teacher&.full_name
  end

  def students
    User.students.where(grade: grade, room: room)
  end

  def name
    "#{grade} #{room}"
  end

  def classroom_subjects
    ClassroomSubject.where(grade: grade, room: room, subject_id: [subjects.ids])
  end

  def infant?
    ["ECD A", "ECD B", "Grade 1", "Grade 2"].include? grade
  end

  def sorted_marks(year = Date.today.year, term = SchoolTerm.get)
    results_hash = Hash.new
    students.each do |s|
      total_actual_mark = s.total_marks_for("Exam", year, term).first
      results_hash[s.id] = total_actual_mark
    end
    r = results_hash.sort
    r.sort_by! { |x| x.last }
    r.reverse.map { |x| [x.last, x.first] }
  end

  private

  def sync_subject_teachers
    if teacher_id_changed?
      if t = User.find_by(id: teacher_id_was)
        t.update_column :grade, "None"
        unless classroom_subjects.where(teacher_id: teacher_id_was).empty?
          classroom_subjects.where(teacher_id: teacher_id_was).update_all(teacher_id: teacher_id)
        end
      end
    end
  end

  def sync_subjects
    subjects.each do |s|
      if classroom_subjects.where(subject: s).empty?
        classroom_subjects.create subject: s
      end
    end
  end

  def sync_teacher
    if teacher
      teacher.update_columns grade: grade, room: room
    end
  end
end
