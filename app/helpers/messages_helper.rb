module MessagesHelper
  def on_messages?
    controller_path == "messages" || controller_path == "private_threads"
  end
end
