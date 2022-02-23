class PaymentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payment_mailer.received.subject
  #
  def received(payment)
    @payment = payment

    mail to: payment.user.email, subject: "Payment Status"
  end
end
