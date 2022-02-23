class RemoveCheckedFromAllowedAnswers < ActiveRecord::Migration[6.1]
  def change
    remove_column :allowed_answers, :checked
  end
end
