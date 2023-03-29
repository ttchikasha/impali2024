# == Schema Information
#
# Table name: classroom_subjects
#
#  id                :bigint           not null, primary key
#  grade             :integer
#  paper1_totalmarks :integer
#  paper2_totalmarks :integer
#  room              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subject_id        :bigint           not null
#  teacher_id        :bigint
#
# Indexes
#
#  index_classroom_subjects_on_subject_id  (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#  fk_rails_...  (teacher_id => users.id)
#
class ClassroomSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher, class_name: "User"
  has_many :topics
  has_many :assignments

  before_create do
    if classroom&.subjects
      classroom&.subjects << subject
    end
  end

  before_destroy do
    classroom&.subjects.delete subject
  end

  validates :room, inclusion: { in: Rooms::TYPES }

  enum grade: Grades::GRADES_HASH

  validates :grade, inclusion: { in: grades.keys }
  validates_uniqueness_of :subject_id, scope: [:teacher_id, :grade, :room]

  before_validation do
    self.teacher = classroom&.teacher if teacher.nil?
  end

  def lessons
    Lesson.where(topic_id: [topic_ids])
  end

  def teacher_name
    teacher&.full_name
  end

  def name
    subject.name
  end

  def classroom
    Classroom.where(grade: grade, room: room).first
  end

  def recent_lessons(count = 3)
    Lesson.where(topic_id: [topics.pluck(:id)]).order(created_at: :desc).take count
  end

  def recent_assignments(count = 2)
    assignments.order(created_at: :desc).take count
  end
end
