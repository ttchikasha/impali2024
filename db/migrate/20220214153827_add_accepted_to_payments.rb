class AddAcceptedToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :accepted, :boolean, default: false
  end
end
