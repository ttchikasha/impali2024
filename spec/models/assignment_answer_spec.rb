# == Schema Information
#
# Table name: assignment_answers
#
#  id            :bigint           not null, primary key
#  score         :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignment_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_assignment_answers_on_assignment_id  (assignment_id)
#  index_assignment_answers_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (assignment_id => assignments.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe AssignmentAnswer, type: :model do
  describe "validations" do
    subject { build :assignment_answer }
    it { should validate_uniqueness_of(:assignment_id).scoped_to(:user_id) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:assignment) }
  end
end
