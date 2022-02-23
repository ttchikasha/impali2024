# == Schema Information
#
# Table name: schedules
#
#  id          :bigint           not null, primary key
#  end         :datetime
#  location    :string
#  start       :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :integer
#
FactoryBot.define do
  factory :schedule do
    title { "MyString" }
    calendar_id { 1 }
    start { "2022-02-11 10:49:50" }
    location { "MyString" }
  end
end
