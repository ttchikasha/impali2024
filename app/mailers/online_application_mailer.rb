class OnlineApplicationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.online_application_mailer.respond.subject
  #
  def respond(online_application)
    @online_application = online_application

    mail to: online_application.email, subject: "Impali Primary School Online Application"
  end
end
