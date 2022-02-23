class CreateJoinTableMessagesUsers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :messages, :users do |t|
      t.index [:message_id, :user_id]
      t.index [:user_id, :message_id]
    end
  end
end
