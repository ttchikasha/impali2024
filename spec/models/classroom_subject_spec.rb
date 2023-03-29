# == Schema Information
#
# Table name: classroom_subjects
#
#  id                :bigint           not null, primary key
#  grade             :integer
#  paper1_totalmarks :integer
#  paper2_totalmarks :integer
#  room              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subject_id        :bigint           not null
#  teacher_id        :bigint
#
# Indexes
#
#  index_classroom_subjects_on_subject_id  (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#  fk_rails_...  (teacher_id => users.id)
#
require 'rails_helper'

RSpec.describe ClassroomSubject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
