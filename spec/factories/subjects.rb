# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subjects_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :subject do
    name { "MyString" }
  end
end
