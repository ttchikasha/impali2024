class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :content
      t.integer :tag, default: 0
      t.integer :to, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :classroom_subject, null: true, foreign_key: true

      t.timestamps
    end
  end
end
