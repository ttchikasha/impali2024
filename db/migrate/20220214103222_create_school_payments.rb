class CreateSchoolPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :school_payments do |t|
      t.decimal :levy, precision: 8, scale: 2
      t.decimal :tution, precision: 8, scale: 2
      t.integer :year, default: Date.today.year
      t.integer :term

      t.timestamps
    end
  end
end
