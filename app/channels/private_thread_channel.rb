class PrivateThreadChannel < ApplicationCable::Channel
  def subscribed
    thread = PrivateThread.find(params[:private_thread_id])
    stream_for thread
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
