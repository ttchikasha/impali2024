# == Schema Information
#
# Table name: allowed_answers
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#
# Indexes
#
#  index_allowed_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class AllowedAnswer < ApplicationRecord
  belongs_to :question
  has_rich_text :content

  validates :content, presence: true
end
