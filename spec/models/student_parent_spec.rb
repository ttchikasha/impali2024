# == Schema Information
#
# Table name: student_parents
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  student_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => users.id)
#  fk_rails_...  (student_id => users.id)
#
require 'rails_helper'

RSpec.describe StudentParent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
