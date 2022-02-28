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

class Lesson < ApplicationRecord
  include BannerImage

  before_save { title&.capitalize! }

  belongs_to :topic
  has_rich_text :content
  has_one_attached :banner_image

  validates :title, presence: true
  validates :video_url, url: { allow_blank: true, allow_nil: true }

  scope :published, -> { where(:draft => false) }
  scope :draft, -> { where(:draft => true) }

  after_save do
    add_banner_image unless banner_image.attached?
  end

  def number
    topic.lessons.index(self) + 1
  end

  def is_teacher?(user)
    topic.classroom_subject.teacher == user
  end
end
