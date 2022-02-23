# == Schema Information
#
# Table name: assignment_answers
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignment_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_assignment_answers_on_assignment_id  (assignment_id)
#  index_assignment_answers_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (assignment_id => assignments.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :assignment_answer do
    assignment { nil }
    user { nil }
  end
end
