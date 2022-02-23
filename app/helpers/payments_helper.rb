module PaymentsHelper
  def on_payments_index?
    controller_name =~ /payments/
  end
end
