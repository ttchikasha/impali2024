# == Schema Information
#
# Table name: online_applications
#
#  id            :bigint           not null, primary key
#  address       :string
#  city          :string
#  comment       :text
#  date_of_birth :date
#  email         :string
#  first_name    :string
#  gender        :string
#  grade         :integer
#  last_name     :string
#  phone         :string
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :online_application do
    first_name { "MyString" }
    last_name { "MyString" }
    phone { "MyString" }
    email { "MyString" }
    grade { 1 }
    gender { "MyString" }
    address { "MyString" }
    city { "MyString" }
  end
end
