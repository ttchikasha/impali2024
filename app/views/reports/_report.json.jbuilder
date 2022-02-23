json.extract! report, :id, :classroom_subject_id, :user_id, :actual_mark, :total_marks, :report_type, :created_at, :updated_at
json.url report_url(report, format: :json)
