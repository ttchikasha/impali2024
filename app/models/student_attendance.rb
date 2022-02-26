# == Schema Information
#
# Table name: student_attendances
#
#  id         :bigint           not null, primary key
#  date       :date             default(Thu, 24 Feb 2022), not null
#  present    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_student_attendances_on_user_id           (user_id)
#  index_student_attendances_on_user_id_and_date  (user_id,date) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class StudentAttendance < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :date, scope: :user_id
end
