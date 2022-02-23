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
FactoryBot.define do
  factory :report do
    classroom_subject { nil }
    user { nil }
    actual_mark { 1 }
    total_marks { 1 }
    report_type { 1 }
  end
end
