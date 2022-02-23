class MessagesController < ApplicationController
  def index
  end

  def create
    @message = Message.new message_params
    @message.user = current_user
    @message.save

    if @message.threadable_type == "PrivateThread"
      PrivateThreadChannel.broadcast_to @message.threadable, { html: render_to_string(@message), sender: @message.user.full_name }
    elsif @message.threadable_type == "Classroom"
      ActionCable.server.broadcast "classrooms", { html: render_to_string(@message), sender: @message.user.full_name, classroom_id: @message.threadable_id }
    end

    @messages = @message.threadable.messages

    respond_to do |format|
      format.js
      format.html { redirect_to @message.threadable }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :threadable_type, :threadable_id)
  end
end
