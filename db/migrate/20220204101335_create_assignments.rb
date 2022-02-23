class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :classroom_subject, null: false, foreign_key: true
      t.timestamp :due

      t.timestamps
    end
  end
end
