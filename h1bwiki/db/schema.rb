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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140204175024) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "applicants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_job_id"
    t.string   "bid_sentence"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "applicants", ["post_job_id"], :name => "index_applicants_on_post_job_id"
  add_index "applicants", ["user_id"], :name => "index_applicants_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "companies", :force => true do |t|
    t.integer  "user_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "website"
    t.string   "sp_transfer"
    t.string   "everified"
    t.string   "training_provided"
    t.string   "accommodation"
    t.text     "description"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso_code_2"
    t.string   "iso_code_3"
    t.string   "address_format"
    t.string   "postcode"
    t.integer  "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "h1bemp_fillings", :force => true do |t|
    t.integer  "h1bemp_id"
    t.string   "filingtype"
    t.string   "filingyear"
    t.string   "filingstatus"
    t.string   "filingcount"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "h1bemp_fillings", ["h1bemp_id"], :name => "index_h1bemp_fillings_on_h1bemp_id"

  create_table "h1bemp_topjobs", :force => true do |t|
    t.integer  "h1bemp_id"
    t.string   "employertitle"
    t.string   "totalcount"
    t.string   "avgsalary"
    t.string   "flag"
    t.string   "rn"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "h1bemp_topjobs", ["h1bemp_id"], :name => "index_h1bemp_topjobs_on_h1bemp_id"

  create_table "h1bemps", :force => true do |t|
    t.string   "employername"
    t.string   "empaddress"
    t.string   "empcity"
    t.string   "empstate"
    t.string   "empzip"
    t.string   "h1btotalapplied"
    t.string   "h1totaldenied"
    t.string   "h1bapprovalrate"
    t.string   "prevh1count"
    t.string   "gctotalapplied"
    t.string   "gctotaldenied"
    t.string   "gcapprovalrate"
    t.string   "prevgccount"
    t.string   "prevh1flag"
    t.string   "prevgcflag"
    t.string   "h1barateflag"
    t.string   "gcarateflag"
    t.string   "everifiedflag"
    t.string   "workforcesize"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "jobseeker_jobs", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.integer  "transfer"
    t.integer  "status"
    t.text     "job_description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "jobseeker_jobs", ["user_id"], :name => "index_jobseeker_jobs_on_user_id"

  create_table "jobseeker_mentors", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.integer  "support"
    t.text     "job_description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "jobseeker_mentors", ["user_id"], :name => "index_jobseeker_mentors_on_user_id"

  create_table "jobseeker_trainings", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.integer  "status"
    t.integer  "transfer"
    t.string   "technology"
    t.integer  "instruction_mod"
    t.integer  "accomodation"
    t.text     "job_description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "jobseeker_trainings", ["user_id"], :name => "index_jobseeker_trainings_on_user_id"

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               :default => false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "post_jobs", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.integer  "job_type"
    t.string   "job_city"
    t.string   "job_state"
    t.string   "job_duration"
    t.text     "job_description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "referral_amount"
    t.string   "duration_type"
    t.string   "salary"
    t.string   "hourly_rate"
  end

  add_index "post_jobs", ["user_id"], :name => "index_post_jobs_on_user_id"

  create_table "post_mentors", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.string   "job_interview"
    t.text     "job_description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "post_mentors", ["user_id"], :name => "index_post_mentors_on_user_id"

  create_table "post_trainings", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.string   "job_technology"
    t.integer  "job_instruction"
    t.string   "job_placement"
    t.string   "job_accomodation"
    t.string   "job_city"
    t.string   "job_state"
    t.string   "job_duration"
    t.text     "job_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "post_trainings", ["user_id"], :name => "index_post_trainings_on_user_id"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "reviews", :force => true do |t|
    t.integer  "h1bemp_id"
    t.integer  "user_id"
    t.string   "paidontime"
    t.string   "placement"
    t.string   "legal"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reviews", ["h1bemp_id"], :name => "index_reviews_on_h1bemp_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "skill_lists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.integer  "skill_list_id"
    t.integer  "skillable_id"
    t.string   "skillable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "skills", ["skill_list_id"], :name => "index_skills_on_skill_list_id"

  create_table "upload_databases", :force => true do |t|
    t.string   "table_name"
    t.text     "data_content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "user_name"
    t.string   "account_type"
    t.string   "immigration_status"
    t.integer  "country_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "contact_number"
    t.boolean  "approved"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "work_authorizations", :force => true do |t|
    t.integer  "post_job_id"
    t.integer  "workauthorization_index"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "work_authorizations", ["post_job_id"], :name => "index_work_authorizations_on_post_job_id"

  add_foreign_key "notifications", "conversations", :name => "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", :name => "receipts_on_notification_id"

end
