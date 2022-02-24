# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
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

class Lesson < ApplicationRecord
  include BannerImage

  belongs_to :topic
  has_rich_text :content
  has_one_attached :banner_image

  after_create :update_lessons_order
  after_destroy :update_lessons_order

  validates :title, presence: true
  validates :video_url, url: { allow_blank: true, allow_nil: true }

  after_save do
    add_banner_image unless banner_image.attached?
  end

  private

  def update_lessons_order
    topic.lessons.each.with_index do |lesson, index|
      if lesson.persisted?
        lesson.order = index + 1
        lesson.save
      end
    end
  end
end
