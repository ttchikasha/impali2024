json.extract! notification, :id, :notifiable_id, :notifiable_type, :title, :content, :created_at, :updated_at
json.url notification_url(notification, format: :json)
