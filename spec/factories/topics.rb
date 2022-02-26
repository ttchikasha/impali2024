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
FactoryBot.define do
  factory :topic do
    title { Faker::Company.bs.capitalize }
    description { Faker::Lorem.paragraphs.join }
    classroom_subject { ClassroomSubject.all.sample || build(:classroom_subject) }
  end
end
