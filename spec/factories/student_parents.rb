# == Schema Information
#
# Table name: student_parents
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  student_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => users.id)
#  fk_rails_...  (student_id => users.id)
#
FactoryBot.define do
  factory :student_parent do
    student_id { "" }
    parent_id { "" }
  end
end
