class CreateQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :question_answers do |t|
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.bigint :selected_answer_id, null: true

      t.timestamps
    end
    add_foreign_key :question_answers, :allowed_answers, column: :selected_answer_id
  end
end
