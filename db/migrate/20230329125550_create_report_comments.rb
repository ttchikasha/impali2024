class CreateReportComments < ActiveRecord::Migration[6.1]
  def change
    create_table :report_comments do |t|
      t.string :co_curricular_activities
      t.string :neatness
      t.string :courtesy
      t.string :conduct
      t.string :deportment
      t.text :comments
      t.references :user, null: false, foreign_key: true
      t.integer :year
      t.integer :term

      t.timestamps
    end
  end
end
