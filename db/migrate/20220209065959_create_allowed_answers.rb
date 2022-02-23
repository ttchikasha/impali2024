class CreateAllowedAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :allowed_answers do |t|
      t.references :question, null: false, foreign_key: true
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
