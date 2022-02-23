# == Schema Information
#
# Table name: online_applications
#
#  id            :bigint           not null, primary key
#  address       :string
#  city          :string
#  comment       :text
#  date_of_birth :date
#  email         :string
#  first_name    :string
#  gender        :string
#  grade         :integer
#  last_name     :string
#  phone         :string
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe OnlineApplication, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
