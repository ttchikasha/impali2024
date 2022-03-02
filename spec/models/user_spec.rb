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
require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:id_no) }
    it { should validate_presence_of(:date_of_birth) }
    it { should validate_presence_of(:start_date) }
    it { should validate_uniqueness_of(:id_no) }
    it { should validate_uniqueness_of(:login_id) }

    it {
      should validate_length_of(:id_no).
               is_at_least(6)
    }

    describe "role validation" do
      it "accepts a valid role" do
        ["Teacher", "Student", "Parent", "Admin"].each do |r|
          u = build :user, role: r
          expect(u).to be_valid
        end
      end

      it "rejects an invalid role" do
        ["Headmaster", SecureRandom.hex(3), "unknown"].each do |r|
          expect { build(:user, role: r) }.to \
            raise_error(ArgumentError, "'#{r}' is not a valid role")
        end
      end

      it "rejects a blank role" do
        u = build :user, role: ""
        expect(u).to be_invalid
      end
    end

    describe "grade validation" do
      it "accepts a valid grade" do
        grades = (0..7).map { |x| x.zero? ? "ECD" : "Grade #{x}" }
        grades.each do |g|
          u = build :user, grade: g
          expect(u).to be_valid
        end
      end

      it "rejects invalid grade" do
        ["Grade 8", "Unknown"].each do |g|
          expect { build(:user, grade: g) }.to \
            raise_error(ArgumentError, "'#{g}' is not a valid grade")
        end
      end

      it "rejects a blank grade" do
        u = build :user, grade: ""
        expect(u).to be_invalid
      end
    end

    describe "room validation" do
      it "accepts a valid room" do
        %w[Red Yellow].each do |r|
          u = build :user, room: r
          expect(u).to be_valid
        end
      end

      it "rejects an invalid room" do
        ["Green", "Blue"].each do |r|
          u = build :user, room: r
          expect(u).to be_invalid
        end
      end

      it "rejects a blank room" do
        u = build :user, room: ""
        expect(u).to be_invalid
      end
    end

    describe "gender validation" do
      it "accepts a valid gender" do
        %w[Male Female].each do |g|
          u = build :user, gender: g
          expect(u).to be_valid
        end
      end

      it "rejects an invalid gender" do
        ["Other", "unknown"].each do |g|
          u = build :user, gender: g
          expect(u).to be_invalid
        end
      end

      it "rejects a blank gender" do
        u = build :user, gender: ""
        expect(u).to be_invalid
      end
    end

    describe "phone validation" do
      it "accepts valid phone numbers" do
        valid_numbers = ["+263 777 330 363", "0777330363", "263777330363", "+263542255114", "777330363"]
        valid_numbers.each do |p|
          u = build :user, phone: p
          expect(u).to be_valid
        end
      end

      it "rejects invalid phone #" do
        invalid_numbers = ["3363", "3", "+2635422558"]
        invalid_numbers.each do |p|
          u = build :user, phone: p
          expect(u).to be_invalid
        end
      end

      it "accepts blank phone number" do
        u = build :user, phone: ""
        expect(u).to be_valid
      end
    end
  end

  describe "associations" do
    it { should have_one_attached(:avatar) }
    it { should have_many(:owned_notifications).class_name("Notification") }
    it { should have_and_belong_to_many(:notifications) }
    it do
      should have_many(:private_threads1)
               .class_name("PrivateThread").with_foreign_key("user1_id")
    end
    it { should have_many(:private_threads2).class_name("PrivateThread").with_foreign_key("user2_id") }
    it { should have_and_belong_to_many(:messages) }
    it { should have_many(:assignment_answers) }
    it { should have_many(:question_answers) }
    it { should have_many(:payments) }
    it { should have_many(:student_attendances) }
    it { should have_one(:student_parent).with_foreign_key :student_id }
    it { should have_one(:parent_student).class_name("StudentParent").with_foreign_key(:parent_id) }
    it { should have_one(:parent).through(:student_parent) }
    it { should have_one(:student).through(:parent_student) }
    it do
      should have_many(:teaching_subjects)
               .class_name("ClassroomSubject").with_foreign_key("teacher_id")
    end
  end
end
