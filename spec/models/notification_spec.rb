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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
