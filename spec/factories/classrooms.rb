# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  grade      :integer
#  room       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
FactoryBot.define do
  factory :classroom do
    grade { User.grades.keys.last }
    room { Rooms::TYPES.sample }
    teacher { User.teachers.sample }
    subject_ids { Subject.all.map(&:id).sample(rand(4..6)) }
  end
end
