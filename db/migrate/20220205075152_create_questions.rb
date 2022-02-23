class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :questionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
