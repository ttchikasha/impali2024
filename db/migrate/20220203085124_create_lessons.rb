class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.references :topic, null: false, foreign_key: true
      t.string :title
      t.string :video_url

      t.timestamps
    end
  end
end
