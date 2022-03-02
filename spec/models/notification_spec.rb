# == Schema Information
#
# Table name: notifications
#
#  id                   :bigint           not null, primary key
#  content              :text
#  tag                  :integer          default("info")
#  title                :string
#  to                   :integer          default("Everyone")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint
#  user_id              :bigint           not null
#
# Indexes
#
#  index_notifications_on_classroom_subject_id  (classroom_subject_id)
#  index_notifications_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }

    describe "tag validation" do
      it "accepts a valid tag" do
        ["info", "success", "warning", "danger"].each do |t|
          u = build :notification, tag: t
          expect(u).to be_valid
        end
      end

      it "rejects an invalid tag" do
        ["primary", SecureRandom.hex(3), "unknown"].each do |t|
          expect { build(:notification, tag: t) }.to \
            raise_error(ArgumentError, "'#{t}' is not a valid tag")
        end
      end

      it "rejects a blank tag" do
        u = build :notification, tag: ""
        expect(u).to be_invalid
      end
    end
  end
end
