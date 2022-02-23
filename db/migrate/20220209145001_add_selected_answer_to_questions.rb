class AddSelectedAnswerToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :selected_answer_id, :bigint, null: true
    add_foreign_key :questions, :allowed_answers, column: :selected_answer_id
  end
end
