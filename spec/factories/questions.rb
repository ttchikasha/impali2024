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
FactoryBot.define do
  factory :question do
    text { Faker::Lorem.paragraphs.join }
    questionable { build :assignment }
  end
end
