class AddNamesToAssignments < ActiveRecord::Migration[6.1]
  def up
    add_column :assignments, :name, :string
    Assignment.all.each do |ass|
      ass.name = "Assignment " + SecureRandom.hex(3)
      ass.save!
    end
  end

  def down
    remove_column :assignments, :name, :string
  end
end
