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
class PrivateThread < ApplicationRecord
  validates_uniqueness_of :user1_id, scope: :user2_id
  belongs_to :user1, class_name: "User", foreign_key: "user1_id"
  belongs_to :user2, class_name: "User", foreign_key: "user2_id"
  has_many :messages, as: :threadable

  def other_user(current_user)
    user1 == current_user ? user2 : user1
  end
end
