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

ActiveRecord::Schema.define(version: 2021_11_15_002226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.text "intro"
    t.string "status"
    t.string "city"
    t.integer "age"
    t.string "preferred_locations"
    t.string "how_did_you_hear"
    t.boolean "work_authorization"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "beta_users", force: :cascade do |t|
    t.string "email"
    t.string "user_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "author"
    t.string "title"
    t.date "published"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cover_photo_file_name"
    t.string "cover_photo_content_type"
    t.bigint "cover_photo_file_size"
    t.datetime "cover_photo_updated_at"
  end

  create_table "calendar_blocks", force: :cascade do |t|
    t.integer "instructor_id"
    t.integer "lesson_time_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "contestants", force: :cascade do |t|
    t.string "username"
    t.string "hometown"
    t.integer "user_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "instructor_id"
    t.integer "requester_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "certification"
    t.string "phone_number"
    t.string "preferred_locations"
    t.string "sport"
    t.text "bio"
    t.text "intro"
    t.string "status"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "city"
    t.integer "adults_initial_rank"
    t.integer "kids_initial_rank"
    t.integer "overall_initial_rank"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "how_did_you_hear"
    t.string "confirmed_certification"
    t.boolean "kids_eligibility"
    t.boolean "seniors_eligibility"
    t.boolean "adults_eligibility"
    t.integer "age"
    t.date "dob"
  end

  create_table "instructors_locations", id: false, force: :cascade do |t|
    t.bigint "instructor_id", null: false
    t.bigint "location_id", null: false
  end

  create_table "instructors_ski_levels", id: false, force: :cascade do |t|
    t.bigint "instructor_id", null: false
    t.bigint "ski_level_id", null: false
  end

  create_table "instructors_snowboard_levels", id: false, force: :cascade do |t|
    t.bigint "instructor_id", null: false
    t.bigint "snowboard_level_id", null: false
  end

  create_table "instructors_sports", id: false, force: :cascade do |t|
    t.bigint "instructor_id", null: false
    t.bigint "sport_id", null: false
  end

  create_table "lesson_actions", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "instructor_id"
    t.string "action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lesson_times", force: :cascade do |t|
    t.date "date"
    t.string "slot"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "requester_id"
    t.integer "instructor_id"
    t.string "ability_level"
    t.string "deposit_status"
    t.bigint "lesson_time_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "activity"
    t.string "requested_location"
    t.string "phone_number"
    t.boolean "gear"
    t.text "objectives"
    t.string "state"
    t.integer "duration"
    t.string "start_time"
    t.string "actual_start_time"
    t.string "actual_end_time"
    t.float "actual_duration"
    t.boolean "terms_accepted"
    t.text "public_feedback_for_student"
    t.text "private_feedback_for_student"
    t.string "focus_area"
    t.string "lift_ticket_status"
    t.string "guest_email"
    t.string "how_did_you_hear"
    t.integer "num_days"
    t.decimal "lesson_price"
    t.string "requester_name"
    t.boolean "is_gift_voucher", default: false
    t.boolean "includes_lift_or_rental_package", default: false
    t.text "package_info"
    t.string "gift_recipient_email"
    t.string "gift_recipient_name"
    t.decimal "lesson_cost"
    t.decimal "non_lesson_cost"
    t.integer "product_id"
    t.string "section_id"
    t.string "product_name"
    t.boolean "lodging_guest"
    t.string "lodging_reservation_id"
    t.string "street_address"
    t.string "city"
    t.string "state_code"
    t.string "zip_code"
    t.string "drivers_license"
    t.date "date"
    t.string "check_in_status"
    t.integer "promo_code_id"
    t.boolean "skip_validations"
    t.integer "shopping_cart_id"
    t.index ["lesson_time_id"], name: "index_lessons_on_lesson_time_id"
  end

  create_table "lessons_shopping_carts", id: false, force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "shopping_cart_id", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "partner_status"
    t.string "calendar_status"
    t.string "region"
    t.string "state"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer "vertical_feet"
    t.integer "base_elevation"
    t.integer "peak_elevation"
    t.integer "skiable_acres"
    t.integer "average_snowfall"
    t.integer "lift_count"
    t.string "address"
    t.boolean "night_skiing"
    t.string "city"
    t.string "state_abbreviation"
    t.date "closing_date"
    t.date "opening_date"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "author_id"
    t.integer "conversation_id"
    t.text "content"
    t.boolean "unread"
    t.integer "recipient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pre_season_location_requests", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_calendars", force: :cascade do |t|
    t.integer "product_id"
    t.integer "price"
    t.date "date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "location_id"
    t.string "calendar_period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "length"
    t.string "slot"
    t.string "start_time"
    t.string "product_type"
    t.boolean "is_lesson", default: false
    t.boolean "is_private_lesson", default: false
    t.boolean "is_group_lesson", default: false
    t.boolean "is_lift_ticket", default: false
    t.boolean "is_rental", default: false
    t.boolean "is_lift_rental_package", default: false
    t.boolean "is_lift_lesson_package", default: false
    t.boolean "is_lift_lesson_rental_package", default: false
    t.boolean "is_multi_day", default: false
    t.string "age_type"
    t.text "details"
    t.string "url"
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string "promo_code"
    t.string "status"
    t.float "discount"
    t.string "discount_type"
    t.integer "redemptions"
    t.string "description"
    t.boolean "single_use"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "instructor_id"
    t.integer "lesson_id"
    t.integer "reviewer_id"
    t.integer "rating"
    t.text "review"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "nps"
  end

  create_table "sections", force: :cascade do |t|
    t.string "age_group"
    t.string "lesson_type"
    t.integer "sport_id"
    t.string "instructor_id"
    t.string "status"
    t.string "level"
    t.integer "capacity"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "shift_id"
    t.string "slot"
  end

  create_table "selfies", force: :cascade do |t|
    t.string "link"
    t.integer "location_id"
    t.integer "contestant_id"
    t.date "date"
    t.string "social_network"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "name"
    t.string "status"
    t.integer "instructor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.string "status"
    t.integer "user_id"
    t.integer "transaction_id"
    t.string "promotions"
    t.text "admin_notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ski_levels", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "snowboard_levels", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "lesson_id"
    t.string "name"
    t.string "age_range"
    t.string "gender"
    t.string "lesson_history"
    t.string "experience"
    t.string "relationship_to_requester"
    t.integer "requester_id"
    t.string "most_recent_experience"
    t.string "most_recent_level"
    t.text "other_sports_experience"
    t.index ["lesson_id"], name: "index_students_on_lesson_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "requester_id"
    t.float "base_amount"
    t.float "tip_amount"
    t.float "final_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "image"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "user_type"
    t.integer "location_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
