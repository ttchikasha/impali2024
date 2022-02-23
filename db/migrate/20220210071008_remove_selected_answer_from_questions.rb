class RemoveSelectedAnswerFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :selected_answer_id
  end
end
