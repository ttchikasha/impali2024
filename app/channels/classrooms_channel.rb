class ClassroomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "classrooms"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
