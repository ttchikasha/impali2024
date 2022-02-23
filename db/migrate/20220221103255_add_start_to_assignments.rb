class AddStartToAssignments < ActiveRecord::Migration[6.1]
  def change
    add_column :assignments, :start, :datetime, null: true
  end
end
