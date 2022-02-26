# == Schema Information
#
# Table name: parents
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  id_no      :string
#  last_name  :string
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
  belongs_to :student, class_name: "User", foreign_key: "user_id"

  before_create do
    User.create! first_name: first_name, last_name: last_name,
                 email: email, phone: phone, id_no: id_no,
                 gender: title == MR ? "Male" : "Female",
                 password: id_no, role: "Parent",
                 city: student.city, address: student.address,
                 date_of_birth: student.date_of_birth,
                 start_date: student.start_date,
                 grade: student.grade, room: student.room
  end

  before_update do
    if id_no_changed?
      user = User.find_by id_no: id_no_was
      user.update_column :id_no, id_no
      user.password = id_no
      user.save!
    end
  end

  ALLOWED_TITLES = [
    MR = "Mr",
    MRS = "Mrs",
    MS = "Ms",
  ]
  validates :title, inclusion: { in: ALLOWED_TITLES }
  validates :phone, phone: true
  validates :id_no, format: {
                      with: %r{\A\d{2}-\d{6,7}[a-zA-Z]\d{2}\z},
                    }

  def formatted_phone
    parsed_phone = Phonelib.parse(phone)
    return phone if parsed_phone.invalid?
    parsed_phone.full_international
  end

  def name
    "#{first_name} #{last_name}"
  end

  def associated_user
    User.find_by id_no: id_no
  end

  private

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end

  def uppercase_id
    self.id_no = id_no.upcase
  end
end
