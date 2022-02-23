class CreatePrivateThreads < ActiveRecord::Migration[6.1]
  def change
    create_table :private_threads do |t|
      t.bigint :user1_id
      t.bigint :user2_id

      t.timestamps
    end

    add_foreign_key :private_threads, :users, column: :user1_id
    add_foreign_key :private_threads, :users, column: :user2_id
  end
end
