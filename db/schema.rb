# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_26_053615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "allowed_answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_allowed_answers_on_question_id"
  end

  create_table "assignment_answers", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id"], name: "index_assignment_answers_on_assignment_id"
    t.index ["user_id"], name: "index_assignment_answers_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "classroom_subject_id", null: false
    t.datetime "due"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start"
    t.index ["classroom_subject_id"], name: "index_assignments_on_classroom_subject_id"
  end

  create_table "classroom_subjects", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "teacher_id"
    t.integer "grade"
    t.string "room"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_classroom_subjects_on_subject_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.bigint "teacher_id"
    t.integer "grade"
    t.string "room"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "classrooms_subjects", id: false, force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "subject_id", null: false
    t.index ["classroom_id", "subject_id"], name: "index_classrooms_subjects_on_classroom_id_and_subject_id"
    t.index ["subject_id", "classroom_id"], name: "index_classrooms_subjects_on_subject_id_and_classroom_id"
  end

  create_table "contact_messages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order", default: 0
    t.string "video_url"
    t.index ["topic_id"], name: "index_lessons_on_topic_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "threadable_type", null: false
    t.bigint "threadable_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["threadable_type", "threadable_id"], name: "index_messages_on_threadable"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "messages_users", id: false, force: :cascade do |t|
    t.bigint "message_id", null: false
    t.bigint "user_id", null: false
    t.index ["message_id", "user_id"], name: "index_messages_users_on_message_id_and_user_id"
    t.index ["user_id", "message_id"], name: "index_messages_users_on_user_id_and_message_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "tag", default: 0
    t.integer "to", default: 0
    t.bigint "user_id", null: false
    t.bigint "classroom_subject_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classroom_subject_id"], name: "index_notifications_on_classroom_subject_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "notifications_users", id: false, force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.bigint "user_id", null: false
    t.index ["notification_id", "user_id"], name: "index_notifications_users_on_notification_id_and_user_id"
    t.index ["user_id", "notification_id"], name: "index_notifications_users_on_user_id_and_notification_id"
  end

  create_table "online_applications", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.integer "grade"
    t.string "gender"
    t.string "address"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date_of_birth"
    t.text "comment"
    t.string "state"
  end

  create_table "parents", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "phone"
    t.string "email"
    t.string "occupation"
    t.string "id_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["user_id"], name: "index_parents_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "term"
    t.integer "year"
    t.decimal "amount", precision: 8, scale: 2
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "accepted", default: false
    t.boolean "rejected", default: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "private_threads", force: :cascade do |t|
    t.bigint "user1_id"
    t.bigint "user2_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.bigint "selected_answer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "mark"
    t.index ["question_id"], name: "index_question_answers_on_question_id"
    t.index ["user_id"], name: "index_question_answers_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "questionable_type", null: false
    t.bigint "questionable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["questionable_type", "questionable_id"], name: "index_questions_on_questionable"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "classroom_subject_id", null: false
    t.bigint "user_id", null: false
    t.integer "actual_mark"
    t.integer "total_marks"
    t.integer "report_type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classroom_subject_id"], name: "index_reports_on_classroom_subject_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "title"
    t.integer "calendar_id"
    t.datetime "start"
    t.datetime "end"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "school_payments", force: :cascade do |t|
    t.decimal "levy", precision: 8, scale: 2
    t.decimal "tution", precision: 8, scale: 2
    t.integer "year", default: 2022
    t.integer "term"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "student_attendances", force: :cascade do |t|
    t.date "date", default: "2022-02-24", null: false
    t.boolean "present", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "date"], name: "index_student_attendances_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_student_attendances_on_user_id"
  end

  create_table "student_parents", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "classroom_subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classroom_subject_id"], name: "index_topics_on_classroom_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "id_no", default: "", null: false
    t.date "date_of_birth"
    t.date "start_date"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0
    t.string "phone"
    t.string "city"
    t.string "address"
    t.string "login_id"
    t.string "room"
    t.integer "grade"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "allowed_answers", "questions"
  add_foreign_key "assignment_answers", "assignments"
  add_foreign_key "assignment_answers", "users"
  add_foreign_key "assignments", "classroom_subjects"
  add_foreign_key "classroom_subjects", "subjects"
  add_foreign_key "classroom_subjects", "users", column: "teacher_id"
  add_foreign_key "classrooms", "users", column: "teacher_id"
  add_foreign_key "lessons", "topics"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "classroom_subjects"
  add_foreign_key "notifications", "users"
  add_foreign_key "parents", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "private_threads", "users", column: "user1_id"
  add_foreign_key "private_threads", "users", column: "user2_id"
  add_foreign_key "question_answers", "allowed_answers", column: "selected_answer_id"
  add_foreign_key "question_answers", "questions"
  add_foreign_key "question_answers", "users"
  add_foreign_key "reports", "classroom_subjects"
  add_foreign_key "reports", "users"
  add_foreign_key "student_attendances", "users"
  add_foreign_key "student_parents", "users", column: "parent_id"
  add_foreign_key "student_parents", "users", column: "student_id"
  add_foreign_key "topics", "classroom_subjects"
end
