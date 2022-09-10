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
  validates :title, presence: true

  enum to: {
    "Everyone": 0,
    "Students": 1,
    "Teachers": 2,
    "Parents": 3,
    "Individuals": 4,
  }

  validates :to, inclusion: tos.keys

  scope :recent, ->(user, count = 4) { for_user(user).order(created_at: :desc).take(count) }
  scope :students_only, -> { where(:to => "Students").or(where(to: "Everyone")) }
  scope :teachers_only, -> { where(:to => "Teachers").or(where(to: "Everyone")) }
  scope :parents_only, -> { where(:to => "Parents").or(where(to: "Everyone")) }

  class << self
    def for_user(user)
      case user.role
      when "Teacher"
        teachers_only
      when "Parent"
        parents_only
      when "Student"
        students_only
      when "Admin"
        all
      end
    end
  end

  def user_authorized?(user)
    return true if user.admin?
    case to
    when "Everyone"
      true
    when "Students"
      user.student? ? true : false
    when "Parents"
      user.parent? ? true : false
    when "Teachers"
      user.teacher? ? true : false
    when "Individuals"
      user.notification_ids.include?(id)
    else
      false
    end
  end

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
