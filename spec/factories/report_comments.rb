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
FactoryBot.define do
  factory :report_comment do
    co_curricular_activities { "MyString" }
    neatness { 1 }
    courtesy { 1 }
    conduct { 1 }
    deportment { 1 }
    comments { "MyText" }
    user { nil }
    year { 1 }
    term { 1 }
  end
end
