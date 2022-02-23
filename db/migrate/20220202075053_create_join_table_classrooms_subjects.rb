class CreateJoinTableClassroomsSubjects < ActiveRecord::Migration[6.1]
  def change
    create_join_table :classrooms, :subjects do |t|
      t.index [:classroom_id, :subject_id]
      t.index [:subject_id, :classroom_id]
    end
  end
end
