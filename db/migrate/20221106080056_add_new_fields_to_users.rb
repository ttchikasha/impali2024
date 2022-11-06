class AddNewFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :parent_occupation, :string, null: true
    add_column :users, :health, :string, null: true
    add_column :users, :physical, :string, null: true
    add_column :users, :religion, :string, null: true
    add_column :users, :languages_spoken, :string, null: true
  end
end
