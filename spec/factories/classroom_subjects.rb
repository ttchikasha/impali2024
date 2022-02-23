# == Schema Information
#
# Table name: classroom_subjects
#
#  id         :bigint           not null, primary key
#  grade      :integer
#  room       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  subject_id :bigint           not null
#  teacher_id :bigint
#
# Indexes
#
#  index_classroom_subjects_on_subject_id  (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#  fk_rails_...  (teacher_id => users.id)
#
FactoryBot.define do
  factory :classroom_subject do
    subject { Subject.all.sample }
    grade { rand(0..7) }
    room { Rooms::TYPES.sample }
    teacher_id { Teacher.all.sample }
  end
end
