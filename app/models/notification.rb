# == Schema Information
#
# Table name: notifications
#
#  id                   :bigint           not null, primary key
#  content              :text
#  tag                  :integer          default("info")
#  title                :string
#  to                   :integer          default("Everyone")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint
#  user_id              :bigint           not null
#
# Indexes
#
#  index_notifications_on_classroom_subject_id  (classroom_subject_id)
#  index_notifications_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true, optional: true
  belongs_to :user
  has_and_belongs_to_many :users

  enum tag: {
    "info": 0,
    "success": 1,
    "warning": 2,
    "danger": 3,
  }
  validates :tag, inclusion: tags.keys

  enum to: {
    "Everyone": 0,
    "Students": 1,
    "Teachers": 2,
  }

  validates :to, inclusion: tos.keys

  scope :recent, ->(count = 4) { order(created_at: :desc).take(count) }

  def icon
    case tag
    when "danger"
      "check-circle"
    when "success"
      "check-circle"
    else
      "exclamation-circle"
    end
  end
end
