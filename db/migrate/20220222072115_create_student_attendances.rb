class CreateStudentAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :student_attendances do |t|
      t.date :date, null: false, default: -> { "NOW()" }
      t.boolean :present, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :student_attendances, %i[user_id date], unique: true
  end
end
