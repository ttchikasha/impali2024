# == Schema Information
#
# Table name: schedules
#
#  id          :bigint           not null, primary key
#  end         :datetime
#  location    :string
#  start       :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :integer
#
require 'rails_helper'

RSpec.describe Schedule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
