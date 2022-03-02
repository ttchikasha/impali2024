# == Schema Information
#
# Table name: assignments
#
#  id                   :bigint           not null, primary key
#  due                  :datetime
#  start                :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint           not null
#
# Indexes
#
#  index_assignments_on_classroom_subject_id  (classroom_subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#
require "rails_helper"

RSpec.describe Assignment, type: :model do
  describe "associations" do
    it { should belong_to(:classroom_subject) }
    it { should have_many(:questions) }
    it { should have_one_attached(:banner_image) }
    it { should have_many(:assignment_answers) }
  end
end
