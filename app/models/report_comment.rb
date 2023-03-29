# == Schema Information
#
# Table name: report_comments
#
#  id                       :bigint           not null, primary key
#  co_curricular_activities :string
#  comments                 :text
#  conduct                  :string
#  courtesy                 :string
#  deportment               :string
#  neatness                 :string
#  term                     :integer
#  year                     :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_report_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ReportComment < ApplicationRecord
  belongs_to :user

  enum term: {
    "Term 1": 1,
    "Term 2": 2,
    "Term 3": 3,
  }

  validates :term, inclusion: { in: terms.keys }

  ALLOCATIONS = [
    VERY_GOOD = "Very Good",
    GOOD = "Good",
    AVERAGE = "Average",
    BELOW_STANDARD = "Below Standard",
  ]

  validates :neatness, inclusion: { in: ALLOCATIONS }

  validates :courtesy, inclusion: { in: ALLOCATIONS }

  validates :deportment, inclusion: { in: ALLOCATIONS }

  validates :conduct, inclusion: { in: ALLOCATIONS }

  validates :year,
            presence: true,
            inclusion: { in: 1900..Date.today.year },
            format: {
              with: /(19|20)\d{2}/i,
              message: "should be a four-digit year",
            }
end
