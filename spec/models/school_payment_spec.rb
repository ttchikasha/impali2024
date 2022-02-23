# == Schema Information
#
# Table name: school_payments
#
#  id         :bigint           not null, primary key
#  levy       :decimal(8, 2)
#  term       :integer
#  tution     :decimal(8, 2)
#  year       :integer          default(2022)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe SchoolPayment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
