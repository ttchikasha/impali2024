# == Schema Information
#
# Table name: question_answers
#
#  id                 :bigint           not null, primary key
#  mark               :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  question_id        :bigint           not null
#  selected_answer_id :bigint
#  user_id            :bigint           not null
#
# Indexes
#
#  index_question_answers_on_question_id  (question_id)
#  index_question_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (selected_answer_id => allowed_answers.id)
#  fk_rails_...  (user_id => users.id)
#
class QuestionAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  belongs_to :selected_answer, class_name: "AllowedAnswer",
                               foreign_key: "selected_answer_id", optional: true
  has_rich_text :answer

  def assignment_answer
    if question.questionable_type == "Assignment"
      user.assignment_answers.where(assignment_id: question.questionable_id).first
    end
  end
end
