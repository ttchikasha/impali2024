# == Schema Information
#
# Table name: results
#
#  id                   :bigint           not null, primary key
#  actual_mark          :integer
#  for                  :integer          default(0)
#  name                 :string           not null
#  term                 :integer
#  total_marks          :integer
#  year                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint           not null
#  student_id           :bigint
#
# Indexes
#
#  index_results_on_classroom_subject_id  (classroom_subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#  fk_rails_...  (student_id => users.id)
#
FactoryBot.define do
  factory :result do
    term { 1 }
    year { 1 }
    actual_mark { 1 }
    total_marks { 1 }
    student_id { "" }
    classroom_subject { nil }
  end
end
