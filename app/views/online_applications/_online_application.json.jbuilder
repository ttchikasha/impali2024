json.extract! online_application, :id, :first_name, :last_name, :phone, :email, :grade, :gender, :address, :city, :created_at, :updated_at
json.url online_application_url(online_application, format: :json)
