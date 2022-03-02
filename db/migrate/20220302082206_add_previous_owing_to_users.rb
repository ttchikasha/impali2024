class AddPreviousOwingToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :previous_owing, :decimal, precision: 8, scale: 2, default: 0
  end
end
