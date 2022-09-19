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
class Result < ApplicationRecord
  validates_presence_of :name

  belongs_to :classroom_subject
  belongs_to :student, class_name: "User"

  validates :year,
            presence: true,
            inclusion: { in: 1900..Date.today.year },
            format: {
              with: /(19|20)\d{2}/i,
              message: "should be a four-digit year",
            }

  enum term: {
    "Term 1": 1,
    "Term 2": 2,
    "Term 3": 3,
  }

  enum for: {
    "Test": 0,
    "Exam": 1,
  }
end
