class CreateClassroomSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :classroom_subjects do |t|
      t.references :subject, null: false, foreign_key: true
      t.bigint :teacher_id
      t.integer :grade
      t.string :room

      t.timestamps
    end
    add_foreign_key :classroom_subjects, :users, column: :teacher_id
  end
end
