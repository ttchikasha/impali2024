class AddPayTypeToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :pay_type, :integer, default: 0
  end
end
