class UseSeparateNameFieldsForParents < ActiveRecord::Migration[6.1]
  def up
    add_column :parents, :first_name, :string
    add_column :parents, :last_name, :string
    Parent.all.each do |p|
      p.update_column :first_name, p.name.split.first
      p.update_column :last_name, p.name.split.last
    end
    remove_column :parents, :name
  end

  def down
    add_column :parents, :name, :string
    Parent.all.each do |p|
      p.update_column :name, "#{p.first_name} #{p.last_name}"
    end
    remove_column :parents, :first_name
    remove_column :parents, :last_name
  end
end
