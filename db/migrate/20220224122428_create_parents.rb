class CreateParents < ActiveRecord::Migration[6.1]
  def change
    create_table :parents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :title
      t.string :phone
      t.string :email
      t.string :occupation
      t.string :id_no

      t.timestamps
    end
  end
end
