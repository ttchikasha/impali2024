# == Schema Information
#
# Table name: assignments
#
#  id                   :bigint           not null, primary key
#  due                  :datetime
#  name                 :string
#  start                :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint           not null
#
# Indexes
#
#  index_assignments_on_classroom_subject_id  (classroom_subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#
class Assignment < ApplicationRecord
  include BannerImage

  belongs_to :classroom_subject
  has_many :questions, as: :questionable
  has_one_attached :banner_image
  has_one_attached :document
  validates :document, file_size: { less_than_or_equal_to: 3_000.kilobytes },
                       file_content_type: { allow: ["application/pdf"] }

  has_many :assignment_answers

  accepts_nested_attributes_for :questions

  after_create :add_banner_image

  before_validation do
    unless start
      self.start = Time.now
    end

    if questions.any?
      rest = questions.slice(1, questions.length).select { |q| !q.text.body.to_plain_text.blank? }
      self.questions = [questions.first].concat(rest)
    end
  end

  def number
    classroom_subject.assignments.index(self) + 1
  end

  # def name
  #   "#{classroom_subject.classroom.name}-#{classroom_subject.name}-Assignment-#{number}"
  # end

  def late?
    due < (Time.zone.now + 2.hours)
  end

  def started?
    (Time.zone.now + 2.hours) > start unless start.nil?
  end

  def can_view?(user)
    if user.teacher? || started?
      return true
    else
      return false
    end
  end
end
