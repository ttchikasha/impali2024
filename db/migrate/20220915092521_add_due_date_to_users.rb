class AddDueDateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :due_date, :date, null: true
  end
end
