# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  city                   :string
#  date_of_birth          :date
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  gender                 :string
#  grade                  :integer
#  id_no                  :string           default(""), not null
#  last_name              :string           default(""), not null
#  phone                  :string
#  phone2                 :string
#  previous_owing         :decimal(8, 2)    default(0.0)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("Student")
#  room                   :string
#  start_date             :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  login_id               :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_login_id              (login_id) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#

cities = ["Harare", "Bulawayo", "Gweru", "Mutare", "Kwekwe", "Kadoma", "Victoria Falls"]

def staff
  date_of_birth { Faker::Date.between from: 60.years.ago, to: 21.years.ago }
  email { "#{first_name.gsub(%r{[^a-zA-Z]}, "").downcase}.#{last_name.gsub(%r{[^a-zA-Z]}, "").downcase}-#{SecureRandom.hex(3)}@example.com" }
  start_date { Faker::Date.between from: date_of_birth + 21.years, to: 1.month.ago }
end

def fake_id_no
  rand(10..99).to_s + "-" + rand(1_000_000..9_999_999).to_s + ("A".."Z").to_a.sample + rand(10..99).to_s
end

FactoryBot.define do
  factory :user do
    id_no { fake_id_no }
    last_name { Faker::Name.last_name }
    email { "user-#{SecureRandom.hex(3)}@example.com" }
    city { cities.sample }
    gender { ["Male", "Female"].sample }
    first_name { gender == "Male" ? Faker::Name.first_name_men : Faker::Name.first_name_women }
    address { Faker::Address.street_address }
    date_of_birth { Faker::Date.birthday }
    password { id_no }
    login_id { nil }
    start_date { Faker::Date.between from: 2.years.ago, to: 1.month.ago }
    room { Rooms::TYPES.sample }
    grade { User.grades.keys.reject { |g| g == "None" }.sample }

    after :build do |user|
      if user.gender == "Male"
        file_names = ["user.png", "man1.jpg", "man2.jpg", "man3.jpg"]
      else
        file_names = ["user.png", "woman1.jpg", "woman2.jpg", "woman3.jpg"]
      end
      file_name = file_names.sample
      file_path = Rails.root.join("spec", "fixtures", "files", file_name)
      user.avatar.attach(io: File.open(file_path), filename: file_name)
    end
  end

  trait :student do
    role { "Student" }
    date_of_birth { Faker::Date.between from: 13.years.ago, to: 5.years.ago }
    email { "student-#{SecureRandom.hex(3)}@example.com" }
    start_date { Faker::Date.between from: date_of_birth + 6.years, to: 1.month.ago }
    room { Rooms::TYPES.sample }
    grade { User.grades.keys.reject { |g| g == "None" }.sample }
  end

  trait :teacher do
    role { "Teacher" }
    room { Rooms::TYPES.sample }
    grade { User.grades.keys.sample }
    staff
  end

  trait :parent do
    role { "Parent" }
    room { Rooms::TYPES.sample }
    grade { User.grades.keys.sample }
    staff
  end

  trait :admin do
    role { "Admin" }
    room { Rooms::TYPES.sample }
    grade { User.grades.keys.sample }
    staff
  end
end
