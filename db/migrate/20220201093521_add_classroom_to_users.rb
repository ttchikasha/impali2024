class AddClassroomToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :room, :string
    add_column :users, :grade, :integer
  end
end
