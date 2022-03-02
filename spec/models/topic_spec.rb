# == Schema Information
#
# Table name: topics
#
#  id                   :bigint           not null, primary key
#  description          :text
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint           not null
#
# Indexes
#
#  index_topics_on_classroom_subject_id  (classroom_subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#
require "rails_helper"

RSpec.describe Topic, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
  end

  describe "associations" do
    it { should have_one_attached(:banner_image) }
    it { should belong_to(:classroom_subject) }
    it { should have_many(:lessons) }
  end
end
