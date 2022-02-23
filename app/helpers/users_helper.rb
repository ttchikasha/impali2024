module UsersHelper
  def on_users_index?
    on_users? && action_name == "index"
  end

  def on_new_user?
    on_users? && action_name == "new"
  end

  def on_edit_user?
    on_users? && action_name == "edit" || action_name == "update"
  end

  def on_user_profile?
    on_users? && action_name == "profile"
  end

  private

  def on_users?
    controller_path == "users"
  end
end
