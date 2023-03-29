class AddTotalExamMarksToClassroomSubjects < ActiveRecord::Migration[6.1]
  def up
    add_column :classroom_subjects, :paper1_totalmarks, :integer
    add_column :classroom_subjects, :paper2_totalmarks, :integer, null: true

    ClassroomSubject.update_all paper1_totalmarks: 50
    ClassroomSubject.update_all paper2_totalmarks: 50
  end

  def down
    remove_column :classroom_subjects, :paper1_totalmarks
    remove_column :classroom_subjects, :paper2_totalmarks
  end
end
