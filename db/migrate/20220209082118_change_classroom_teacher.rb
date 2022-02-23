class ChangeClassroomTeacher < ActiveRecord::Migration[6.1]
  def change
    change_column_null :classrooms, :teacher_id, true
  end
end
