# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  name       :string
#  target     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Subject < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :target
  has_many :classroom_subjects
  scope :infants, -> { where(target: "Infants") }
  scope :juniors, -> { where(target: nil) }
end
