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
class Schedule < ApplicationRecord
end
