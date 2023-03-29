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
require 'rails_helper'

RSpec.describe ReportComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
