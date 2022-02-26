# == Schema Information
#
# Table name: parents
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  id_no      :string
#  last_name  :string
#  occupation :string
#  phone      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_parents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :parent do
    user { nil }
    name { "MyString" }
    title { "MyString" }
    phone { "MyString" }
    email { "MyString" }
    occupation { "MyString" }
    id_no { "MyString" }
  end
end
