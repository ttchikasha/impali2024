class AddNameToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :name, :string, null: false
  end
end
