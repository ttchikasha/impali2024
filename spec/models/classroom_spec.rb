# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  grade      :integer
#  room       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
require "rails_helper"

RSpec.describe Classroom, type: :model do
  describe "associations" do
    it { should belong_to(:teacher).class_name("User").optional }
    it { should have_and_belong_to_many(:subjects) }
    it { should have_many(:messages) }
  end

  describe "validations" do
    describe "grade validation" do
      it "accepts a valid grade" do
        grades = (0..7).map { |x| x.zero? ? "ECD" : "Grade #{x}" }
        grades.each do |g|
          u = build :classroom, grade: g
          expect(u).to be_valid
        end
      end

      it "rejects invalid grade" do
        ["Grade 8", "Unknown"].each do |g|
          expect { build(:classroom, grade: g) }.to \
            raise_error(ArgumentError, "'#{g}' is not a valid grade")
        end
      end

      it "rejects a blank grade" do
        u = build :classroom, grade: ""
        expect(u).to be_invalid
      end
    end
  end
end
