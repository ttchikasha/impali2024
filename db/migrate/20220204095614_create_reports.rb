class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :classroom_subject, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :actual_mark
      t.integer :total_marks
      t.integer :report_type, default: 0

      t.timestamps
    end
  end
end
