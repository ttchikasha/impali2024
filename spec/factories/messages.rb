# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  content         :text
#  threadable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  threadable_id   :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_threadable  (threadable_type,threadable_id)
#  index_messages_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :message do
    user { nil }
    threadable { nil }
    content { "MyText" }
  end
end
