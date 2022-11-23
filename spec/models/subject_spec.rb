# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  name       :string
#  target     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Subject, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { should have_many(:classroom_subjects) }
  end
end
