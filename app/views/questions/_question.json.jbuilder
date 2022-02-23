json.extract! question, :id, :text, :questionable_id, :questionable_type, :created_at, :updated_at
json.url question_url(question, format: :json)
json.text question.text.to_s
