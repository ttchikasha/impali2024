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
class SchoolPayment < ApplicationRecord
  enum term: {
    "Term 1": 1,
    "Term 2": 2,
    "Term 3": 3,
  }
  validates :term, inclusion: terms.keys

  scope :current, -> { where(:year => Date.today.year).first || self.first }
  # Ex:- scope :active, -> {where(:active => true)}

  class << self
    def total_this_term
      curr = SchoolPayment.current
      curr.levy + curr.tution
    end

    def years
      result = []
      ((Date.today.year - 1)..(Date.today.year + 4)).each do |n|
        result << [n, n]
      end
      result
    end
  end
end
