class AddPhone2ToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone2, :string
  end
end
