json.extract! school_payment, :id, :levy, :tution, :year, :term, :created_at, :updated_at
json.url school_payment_url(school_payment, format: :json)
