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
require "rails_helper"

RSpec.describe AllowedAnswer, type: :model do
  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  describe "associations" do
    it { should belong_to(:question) }
    it { should have_rich_text(:content) }
  end
end
