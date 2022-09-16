class AddDraftToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :draft, :boolean, default: true
  end
end
