class AddRejectedToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :rejected, :boolean, default: false
  end
end
