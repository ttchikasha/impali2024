class AddMarkToQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :question_answers, :mark, :integer, null: true
  end
end
