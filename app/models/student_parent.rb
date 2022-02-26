# == Schema Information
#
# Table name: student_parents
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  student_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => users.id)
#  fk_rails_...  (student_id => users.id)
#
class StudentParent < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id"
  belongs_to :parent, class_name: "User", foreign_key: "parent_id"

  before_validation :set_parent_details, on: :create

  accepts_nested_attributes_for :parent

  private

  def set_parent_details
    self.parent.city = student.city
    self.parent.address = student.address
    self.parent.grade = student.grade
    self.parent.room = student.room
    self.parent.role = "Parent"
    self.parent.start_date = student.start_date
    self.parent.date_of_birth = rand(30..50).years.ago
  end
end
