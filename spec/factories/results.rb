# == Schema Information
#
# Table name: results
#
#  id                   :bigint           not null, primary key
#  actual_mark          :integer
#  for                  :integer          default("Test")
#  grade                :integer
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
    name { ["Paper 1", "Paper 2"].sample }
    term { SchoolTerm.get }
    year { Date.today.year }
    actual_mark { rand(30..50) }
    total_marks { 50 }
    student { User.students.sample }
    classroom_subject { student.classroom_subjects.sample }
  end
end
