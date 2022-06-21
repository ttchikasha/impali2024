class AlterTeacherInClassrooms < ActiveRecord::Migration[6.1]
  def up
    change_column :classrooms, :teacher_id, :bigint, :null => true
  end

  def down
    change_column :classrooms, :teacher_id, :bigint, :null => false
  end
end
