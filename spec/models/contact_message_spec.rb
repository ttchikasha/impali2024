# == Schema Information
#
# Table name: contact_messages
#
#  id         :bigint           not null, primary key
#  email      :string
#  message    :text
#  name       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
