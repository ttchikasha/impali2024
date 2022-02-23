# == Schema Information
#
# Table name: reports
#
#  id                   :bigint           not null, primary key
#  actual_mark          :integer
#  report_type          :integer          default("Homework")
#  total_marks          :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_reports_on_classroom_subject_id  (classroom_subject_id)
#  index_reports_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Report, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
