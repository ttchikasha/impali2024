# == Schema Information
#
# Table name: questions
#
#  id                :bigint           not null, primary key
#  questionable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  questionable_id   :bigint           not null
#
# Indexes
#
#  index_questions_on_questionable  (questionable_type,questionable_id)
#
require 'rails_helper'

RSpec.describe Question, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
