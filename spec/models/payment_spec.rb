# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  accepted   :boolean          default(FALSE)
#  amount     :decimal(8, 2)
#  rejected   :boolean          default(FALSE)
#  term       :integer
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Payment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
