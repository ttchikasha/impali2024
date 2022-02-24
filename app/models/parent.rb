# == Schema Information
#
# Table name: parents
#
#  id         :bigint           not null, primary key
#  email      :string
#  id_no      :string
#  name       :string
#  occupation :string
#  phone      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_parents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Parent < ApplicationRecord
  before_save :normalize_phone, :uppercase_id
  belongs_to :user

  ALLOWED_TITLES = [
    MR = "Mr",
    MRS = "Mrs",
    MS = "Ms",
    DR = "Dr",
  ]
  validates :title, inclusion: { in: ALLOWED_TITLES }
  validates :phone, phone: true
  validates :id_no, format: {
                      with: %r{\d{2}-\d{6,7}[a-zA-Z]\d{2}},
                    }

  def formatted_phone
    parsed_phone = Phonelib.parse(phone)
    return phone if parsed_phone.invalid?
    parsed_phone.full_international
  end

  private

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end

  def uppercase_id
    self.id_no = id_no.upcase
  end
end
