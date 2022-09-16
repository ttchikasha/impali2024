# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
#  draft      :boolean          default(TRUE)
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
FactoryBot.define do
  factory :lesson do
    topic { Topic.all.sample || build(:topic) }
    title { Faker::Lorem.words.join }
    content { Faker::Lorem.paragraphs.join }
    video_url { "" }
  end
end
