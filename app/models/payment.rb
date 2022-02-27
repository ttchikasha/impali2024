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
class Payment < ApplicationRecord
  belongs_to :user
  has_one_attached :deposit_slip
  has_many :user_payments

  before_create do
    if user.parent?
      self.user = user.student
    end
  end

  enum term: {
    "Term 1": 1,
    "Term 2": 2,
    "Term 3": 3,
  }
  validates :term, inclusion: terms.keys

  scope :accepted, -> { where(:accepted => true) }
  scope :revenues, ->(period = nil) do
          case period
          when "Today"
            accepted.where("created_at > ?", 1.day.ago)
          when "Week"
            accepted.where("created_at > ?", 1.week.ago)
          when "Month"
            accepted.where("created_at > ?", 1.month.ago)
          else
            accepted
          end
        end
  scope :total_revenue, ->(period = nil) { revenues(period).sum(&:amount) }

  scope :total_students_paid, ->(period = nil) { revenues(period).group(:user).count.keys.length }

  after_update do
    PaymentMailer.received(self).deliver_later
  end

  def payment_id
    "##{id}-#{user.login_id}"
  end

  def status
    return "Accepted" if accepted
    return "Rejected" if rejected
    "Pending"
  end

  def status_class
    return "bg-success" if accepted
    return "bg-danger" if rejected
    "bg-dark"
  end

  class << self
    def years
      result = []
      ((Date.today.year)..(Date.today.year + 2)).each do |n|
        result << [n, n]
      end
      result
    end
  end
end
