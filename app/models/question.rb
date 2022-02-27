# == Schema Information
#
# Table name: questions
#
#  id                :bigint           not null, primary key
#  questionable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  questionable_id   :bigint           not null
#
# Indexes
#
#  index_questions_on_questionable  (questionable_type,questionable_id)
#
class Question < ApplicationRecord
  belongs_to :questionable, polymorphic: true
  has_rich_text :text
  validates :text, presence: true
  has_many :allowed_answers, dependent: :destroy
  has_many :question_answers, dependent: :destroy

  accepts_nested_attributes_for :allowed_answers
  accepts_nested_attributes_for :question_answers

  default_scope { order(:created_at) }

  before_validation do
    rest = allowed_answers&.select { |a| !a.content.body.to_plain_text.blank? }

    self.allowed_answers = rest if rest
  end

  def number
    questionable.questions.index(self) + 1
  end

  def classroom_name
    questionable.classroom_subject.classroom.name
  end

  def owned_by?(user)
    return false unless user.teacher?
    user&.classroom_subjects&.include? questionable.classroom_subject
  end

  def correct_answer
    teacher = questionable.classroom_subject.classroom.teacher
    question_answers.find_by_user_id teacher.id
  end
end
