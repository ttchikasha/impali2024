# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subjects_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Subject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
