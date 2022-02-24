class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(to, message)
    client = Twilio::REST::Client.new
    client.messages.create \
      from: Rails.application.credentials.dig(:twilio, :phone_number),
      to: to,
      body: message
  end
end
