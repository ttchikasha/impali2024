class AddScoreToAssignmentAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :assignment_answers, :score, :integer, default: 0
  end
end
