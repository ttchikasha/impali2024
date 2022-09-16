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

class Lesson < ApplicationRecord
  include BannerImage

  before_save { title&.capitalize! }

  belongs_to :topic
  has_rich_text :content
  has_one_attached :banner_image
  has_one_attached :document

  validates :title, presence: true
  validates :video_url, url: { allow_blank: true, allow_nil: true }
  validates :banner_image, file_size: { less_than_or_equal_to: 200.kilobytes },
                           file_content_type: { allow: ["image/jpeg", "image/png"] }
  validates :document, file_size: { less_than_or_equal_to: 200.kilobytes },
                       file_content_type: { allow: ["application/pdf"] }

  scope :published, -> { where.not(:draft => true) }
  scope :draft, -> { where(:draft => true) }

  after_save do
    unless banner_image.attached?
      add_banner_image
    end
  end

  def number
    topic.lessons.index(self) + 1
  end

  def is_teacher?(user)
    topic.classroom_subject.teacher == user
  end
end
