class CreateOnlineApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :online_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.integer :grade
      t.string :gender
      t.string :address
      t.string :city

      t.timestamps
    end
  end
end
