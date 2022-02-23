module NotificationsHelper
  def on_notifications?
    controller_path == "notifications"
  end
end
