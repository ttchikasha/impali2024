class RemoveNameIndexFromSubjects < ActiveRecord::Migration[6.1]
  def change
    remove_index :subjects, :name
  end
end
