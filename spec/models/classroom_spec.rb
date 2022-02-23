# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  grade      :integer
#  room       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
require 'rails_helper'

RSpec.describe Classroom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
