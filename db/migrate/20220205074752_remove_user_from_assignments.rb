class RemoveUserFromAssignments < ActiveRecord::Migration[6.1]
  def change
    remove_column :assignments, :user_id
  end
end
