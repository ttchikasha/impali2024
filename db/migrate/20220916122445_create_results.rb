class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :term
      t.integer :year
      t.integer :actual_mark
      t.integer :total_marks
      t.bigint :student_id
      t.references :classroom_subject, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :results, :users, column: :student_id
  end
end
