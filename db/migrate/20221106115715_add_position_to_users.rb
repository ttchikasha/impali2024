class AddPositionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :position, :string, null: true
  end
end
