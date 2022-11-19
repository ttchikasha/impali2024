class AddGradeToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :grade, :integer
  end
end
