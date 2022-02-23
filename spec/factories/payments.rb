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
FactoryBot.define do
  factory :payment do
    term { "Term 1" }
    year { Date.today.year }
    amount { rand(10..100) }
    user { User.students.sample }

    after :build do |payment|
      file_name = "deposit.jpg"
      file_path = Rails.root.join("spec", "fixtures", "files", file_name)
      payment.deposit_slip.attach(io: File.open(file_path), filename: file_name)
    end
  end
end
