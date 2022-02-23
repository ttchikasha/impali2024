json.extract! payment, :id, :term, :year, :deposit_slip, :amount, :user_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
json.deposit_slip url_for(payment.deposit_slip)
