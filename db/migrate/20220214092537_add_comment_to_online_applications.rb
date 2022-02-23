class AddCommentToOnlineApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :online_applications, :comment, :text
  end
end
