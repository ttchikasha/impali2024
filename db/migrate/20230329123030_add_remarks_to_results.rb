class AddRemarksToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :remarks, :text
  end
end
