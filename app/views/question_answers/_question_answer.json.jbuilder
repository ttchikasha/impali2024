json.extract! question_answer, :id, :question_id, :user_id, :selected_answer, :answer, :created_at, :updated_at
json.url question_answer_url(question_answer, format: :json)
json.answer question_answer.answer.to_s
