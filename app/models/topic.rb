# == Schema Information
#
# Table name: topics
#
#  id                   :bigint           not null, primary key
#  description          :text
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint           not null
#
# Indexes
#
#  index_topics_on_classroom_subject_id  (classroom_subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#
class Topic < ApplicationRecord
  include BannerImage

  belongs_to :classroom_subject
  has_many :lessons
  has_one_attached :banner_image

  validates :title, presence: true

  after_create :add_banner_image
end
