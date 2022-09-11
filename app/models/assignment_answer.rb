# == Schema Information
#
# Table name: assignment_answers
#
#  id            :bigint           not null, primary key
#  score         :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignment_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_assignment_answers_on_assignment_id  (assignment_id)
#  index_assignment_answers_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (assignment_id => assignments.id)
#  fk_rails_...  (user_id => users.id)
#
class AssignmentAnswer < ApplicationRecord
  belongs_to :assignment
  belongs_to :user
  has_one_attached :document
  validates :document, file_size: { less_than_or_equal_to: 256.kilobytes },
                       file_content_type: { allow: ["application/pdf"] }

  validates_uniqueness_of :assignment_id, scope: :user_id

  before_save do
    unless document.attached?
      self.score = calculate_score
    end
  end

  def classroom_subject
    assignment.classroom_subject
  end

  def mc_questions
    assignment.questions.select { |q| q.allowed_answers.any? }
  end

  def other_questions
    assignment.questions.select { |q| q.allowed_answers.blank? }
  end

  def mark
    total = 0
    mc_questions.each do |q|
      user_answer = user.question_answers.where(question_id: q.id).first
      teacher = classroom_subject.classroom.teacher
      teacher_answer = teacher.question_answers.where(question_id: q.id).first
      if user_answer&.selected_answer && teacher_answer&.selected_answer
        if user_answer.selected_answer_id == teacher_answer.selected_answer_id
          total += 1
        end
      end
    end
    total
  end

  def total_marks
    mc_questions.count
  end

  def set_score!
    self.score = calculate_score
    save!
  end

  private

  def calculate_score
    marks = []
    other_questions.each do |q|
      qa = user.question_answers.where(question_id: q.id).first
      marks << (qa.mark || 0)
    end
    mc_mark = total_marks.zero? ? 0 : mark.to_f / total_marks * 100
    if marks.any?
      avg = marks.reduce(:+) / marks.size.to_f
      (avg + mc_mark) / 2
    else
      mc_mark
    end
  end
end
