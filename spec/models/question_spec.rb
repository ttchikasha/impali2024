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
require "rails_helper"

RSpec.describe Question, type: :model do
  describe "associations" do
    it { should belong_to(:questionable) }
    it { should have_many(:allowed_answers).dependent(:destroy) }
    it { should have_many(:question_answers).dependent(:destroy) }
  end

  describe "validations" do
    it { should have_rich_text(:text) }
    it { should validate_presence_of(:text) }
  end
end
