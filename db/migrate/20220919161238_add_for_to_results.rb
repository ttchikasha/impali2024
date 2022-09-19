class AddForToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :for, :integer, default: 0
  end
end
