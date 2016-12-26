# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140115000809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country_code"
    t.string   "state_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_code", "state_code"], name: "index_cities_on_country_code_and_state_code", using: :btree
  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree

  create_table "countries", force: true do |t|
    t.string   "code",       limit: 2
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["code"], name: "index_countries_on_code", unique: true, using: :btree
  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "flirts", force: true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "internal_notifications", force: true do |t|
    t.text     "message"
    t.boolean  "displayed",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "read",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted_by_sender",    default: false
    t.boolean  "deleted_by_recipient", default: false
    t.boolean  "abuse",                default: false
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "payments_loggers", force: true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  add_index "payments_loggers", ["user_id"], name: "index_payments_loggers_on_user_id", using: :btree

  create_table "profile_answers", force: true do |t|
    t.integer  "profile_question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_answers", ["profile_question_id"], name: "index_profile_answers_on_profile_question_id", using: :btree

  create_table "profile_questions", force: true do |t|
    t.string   "question"
    t.integer  "profile_section_id"
    t.string   "answer_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "reverse_question"
  end

  add_index "profile_questions", ["profile_section_id"], name: "index_profile_questions_on_profile_section_id", using: :btree

  create_table "profile_sections", force: true do |t|
    t.string   "name"
    t.boolean  "displayed",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "reverse_name"
  end

  create_table "profile_visits", force: true do |t|
    t.integer  "viewer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_visits", ["user_id", "created_at"], name: "index_profile_visits_on_user_id_and_created_at", using: :btree
  add_index "profile_visits", ["user_id"], name: "index_profile_visits_on_user_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "country_code"
    t.string   "state_code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["country_code", "state_code"], name: "index_states_on_country_code_and_state_code", using: :btree

  create_table "subscriptions", force: true do |t|
    t.decimal  "member_id"
    t.decimal  "trans_id"
    t.string   "auth_code"
    t.datetime "auth_date"
    t.string   "auth_msg"
    t.decimal  "recurring_id"
    t.string   "avs_code"
    t.string   "cvv2_code"
    t.decimal  "settle_amount",      precision: 10, scale: 2
    t.string   "settle_currency"
    t.string   "processor"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upgrade_ip_address"
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "user_activities", force: true do |t|
    t.integer  "user_id"
    t.string   "activity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
  end

  add_index "user_activities", ["gender"], name: "index_user_activities_on_gender", using: :btree
  add_index "user_activities", ["user_id"], name: "index_user_activities_on_user_id", using: :btree

  create_table "user_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "visitor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_likes", ["user_id"], name: "index_user_likes_on_user_id", using: :btree
  add_index "user_likes", ["visitor_id"], name: "index_user_likes_on_visitor_id", using: :btree

  create_table "user_logs", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "likes_viewed_at"
    t.datetime "views_viewed_at"
  end

  add_index "user_logs", ["user_id"], name: "index_user_logs_on_user_id", using: :btree

  create_table "user_photos", force: true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "approved",           default: false
  end

  add_index "user_photos", ["user_id"], name: "index_user_photos_on_user_id", using: :btree

  create_table "user_profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "about_me"
    t.text     "looking_for"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

  create_table "user_questions", force: true do |t|
    t.integer  "user_id"
    t.integer  "profile_question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_questions", ["user_id", "profile_question_id"], name: "index_user_questions_on_user_id_and_profile_question_id", using: :btree

  create_table "user_settings", force: true do |t|
    t.boolean  "messages_email",  default: true
    t.boolean  "flirts_email",    default: true
    t.boolean  "matches_email",   default: true
    t.boolean  "views_email",     default: true
    t.boolean  "likes_email",     default: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "new_users_email", default: true
    t.boolean  "unsubscribed",    default: false
  end

  add_index "user_settings", ["user_id"], name: "index_user_settings_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                                        null: false
    t.string   "email",                                           null: false
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "country"
    t.string   "zip_code"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "failed_logins_count",             default: 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "city"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "type"
    t.integer  "profile_photo_id"
    t.integer  "rating",                          default: 1
    t.string   "last_login_from_ip_address"
    t.boolean  "active",                          default: true
    t.string   "signup_ip_address"
    t.string   "state"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "country_code"
    t.string   "unsubscribe_token"
    t.string   "state_code"
    t.boolean  "blocked",                         default: false
    t.integer  "user_photos_count",               default: 0,     null: false
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["active"], name: "index_users_on_active", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["state_id", "city_id"], name: "index_users_on_state_id_and_city_id", using: :btree
  add_index "users", ["type", "active"], name: "index_users_on_type_and_active", using: :btree
  add_index "users", ["type", "last_logout_at"], name: "index_users_on_type_and_last_logout_at", using: :btree
  add_index "users", ["type", "username"], name: "index_users_on_type_and_username", using: :btree
  add_index "users", ["type"], name: "index_users_on_type", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
