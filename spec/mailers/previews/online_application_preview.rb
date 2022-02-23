# Preview all emails at http://localhost:3000/rails/mailers/online_application
class OnlineApplicationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/online_application/respond
  def respond
    OnlineApplicationMailer.respond
  end

end
