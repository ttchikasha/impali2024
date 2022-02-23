class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :threadable, polymorphic: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
