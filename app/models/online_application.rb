# == Schema Information
#
# Table name: online_applications
#
#  id            :bigint           not null, primary key
#  address       :string
#  city          :string
#  comment       :text
#  date_of_birth :date
#  email         :string
#  first_name    :string
#  gender        :string
#  grade         :integer
#  last_name     :string
#  phone         :string
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class OnlineApplication < ApplicationRecord
  validates :first_name, :last_name, :phone, :email, :gender, :address, presence: true
  has_many_attached :files

  enum grade: Grades::GRADES_HASH

  before_update do
    if comment.blank?
      self.comment = case state
        when "Wait"
          comment = "Your application has been put on the waiting list and you will be notified"
        when "Reject"
          comment = "We are sorry to inform you that your online application was not successful."
        else
          comment = "Congratulations, your application was successful. Come to the school to complete the application process."
        end
    end
  end

  after_update { OnlineApplicationMailer.respond(self).deliver_later }

  STATES = [
    ACCEPT = "Accept",
    REJECT = "Reject",
    PENDING = "Wait",
  ]

  validates :state, inclusion: { in: STATES }

  before_save { self.state = PENDING unless state }

  def full_name
    first_name + " " + last_name
  end

  def responses
    application_responses.select(&:persisted?)
  end

  def css_class
    case state
    when "Accept"
      "success"
    when "Reject"
      "danger"
    else
      "warning"
    end
  end

  def state_name
    case state
    when "Accept"
      "Accepted"
    when "Reject"
      "Rejected"
    else
      "Pending"
    end
  end
end
