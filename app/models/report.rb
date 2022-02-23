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
class Report < ApplicationRecord
  belongs_to :classroom_subject
  belongs_to :user

  enum report_type: {
    "Homework" => 0,
    "Test" => 1,
    "Examination" => 2,
  }

  validates :actual_mark, :total_marks, presence: true
  validates :report_type, inclusion: report_types.keys
end
