class AddTargetToSubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :target, :string
  end
end
