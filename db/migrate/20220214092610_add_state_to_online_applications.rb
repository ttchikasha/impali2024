class AddStateToOnlineApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :online_applications, :state, :string
  end
end
