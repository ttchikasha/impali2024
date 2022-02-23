class AddOrderToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :order, :bigint, default: 0
  end
end
