# == Schema Information
#
# Table name: private_threads
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user1_id   :bigint
#  user2_id   :bigint
#
# Foreign Keys
#
#  fk_rails_...  (user1_id => users.id)
#  fk_rails_...  (user2_id => users.id)
#
FactoryBot.define do
  factory :private_thread do
    user1_id { "" }
    user2_id { "" }
  end
end
