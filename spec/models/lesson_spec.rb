# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
#  draft      :boolean
#  order      :bigint           default(0)
#  title      :string
#  video_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#
# Indexes
#
#  index_lessons_on_topic_id  (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#
require 'rails_helper'

RSpec.describe Lesson, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
