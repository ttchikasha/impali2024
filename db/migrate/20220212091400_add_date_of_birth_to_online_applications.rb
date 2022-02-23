class AddDateOfBirthToOnlineApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :online_applications, :date_of_birth, :date
  end
end
