json.extract! lesson, :id, :topic_id, :title, :video_url, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
