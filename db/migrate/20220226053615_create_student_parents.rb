class CreateStudentParents < ActiveRecord::Migration[6.1]
  def change
    create_table :student_parents do |t|
      t.bigint :student_id
      t.bigint :parent_id

      t.timestamps
    end

    add_foreign_key :student_parents, :users, column: :student_id
    add_foreign_key :student_parents, :users, column: :parent_id
  end
end
