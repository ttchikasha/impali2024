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
FactoryBot.define do
  factory :school_payment do
    levy { "9.99" }
    tution { "9.99" }
    year { 1 }
    term { 1 }
  end
end
