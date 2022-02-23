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
FactoryBot.define do
  factory :assignment do
    classroom_subject { ClassroomSubject.all.sample }
    due { "2022-02-10 12:00:00" }
  end
end
