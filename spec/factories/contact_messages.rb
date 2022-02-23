# == Schema Information
#
# Table name: contact_messages
#
#  id         :bigint           not null, primary key
#  email      :string
#  message    :text
#  name       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :contact_message do
    name { "MyString" }
    email { "MyString" }
    subject { "MyString" }
    message { "MyText" }
  end
end
