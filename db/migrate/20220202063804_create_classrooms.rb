class CreateClassrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :classrooms do |t|
      t.bigint :teacher_id
      t.integer :grade
      t.string :room

      t.timestamps
    end
    add_foreign_key :classrooms, :users, column: :teacher_id
  end
end
