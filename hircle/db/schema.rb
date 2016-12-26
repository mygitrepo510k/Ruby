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

ActiveRecord::Schema.define(:version => 20130522134240) do

  create_table "activities", :force => true do |t|
    t.string   "activity_type"
    t.datetime "create_date"
    t.integer  "activity_by_id"
    t.integer  "activity_with_id"
    t.integer  "company_id"
    t.integer  "department_id"
    t.integer  "conversation_id"
  end

  add_index "activities", ["activity_by_id"], :name => "index_activities_on_activity_by_id"
  add_index "activities", ["activity_with_id"], :name => "index_activities_on_activity_with_id"
  add_index "activities", ["company_id"], :name => "index_activities_on_company_id"

  create_table "assignments", :force => true do |t|
    t.integer  "assignee_id"
    t.integer  "task_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "create_at"
    t.integer  "parent_id"
    t.integer  "activity_id"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.string   "city"
    t.string   "state"
    t.string   "website"
    t.integer  "plan_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "conversation_metadata", :force => true do |t|
    t.integer  "conversations_id"
    t.integer  "user_id"
    t.boolean  "archived",         :default => false
    t.boolean  "read",             :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "conversation_metadata", ["conversations_id"], :name => "index_conversation_metadata_on_conversations_id"
  add_index "conversation_metadata", ["user_id"], :name => "index_conversation_metadata_on_user_id"

  create_table "conversations", :force => true do |t|
    t.text    "content"
    t.integer "company_id"
    t.integer "user_id"
  end

  create_table "coversations_users", :id => false, :force => true do |t|
    t.integer "coversation_id"
    t.integer "user_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "company_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "edu_histories", :force => true do |t|
    t.string   "school_name"
    t.string   "city"
    t.string   "state"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "program"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "emp_histories", :force => true do |t|
    t.string   "company"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "job_title"
    t.text     "job_desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "channel"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "invitation_message"
    t.string   "role_id"
  end

  create_table "job_applications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.boolean  "watch",      :default => false
    t.boolean  "like",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "job_invitations", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "invited_id"
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobs", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "field"
    t.string   "tag"
    t.integer  "visibility"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.string   "subject"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "card_expires_on"
    t.string   "card_type"
    t.string   "first_name"
    t.string   "ip_address"
    t.string   "last_name"
    t.string   "card_number"
    t.date     "card_verification"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.string   "plan_type"
    t.float    "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.string  "alternate_email"
    t.string  "phone"
    t.string  "address"
    t.integer "department_id"
    t.integer "user_id"
    t.string  "motto"
  end

  add_index "profiles", ["department_id"], :name => "index_profiles_on_department_id"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.string   "pointer"
    t.string   "resource_type"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "update_at"
    t.string   "attach_content_type"
    t.string   "attach_file_name"
    t.integer  "attach_file_size"
    t.integer  "conversation_id"
    t.integer  "department_id"
  end

  create_table "resumes", :force => true do |t|
    t.text     "career_obj"
    t.string   "skills"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "social_authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spaces", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.integer  "company_id",  :null => false
    t.integer  "creator_id",  :null => false
    t.string   "status"
    t.datetime "create_date"
    t.datetime "update_date"
  end

  add_index "spaces", ["creator_id"], :name => "index_spaces_on_creator_id"

  create_table "spaces_users", :force => true do |t|
    t.integer "users_id"
    t.integer "spaces_id"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.string   "priority"
    t.datetime "start_date"
    t.datetime "due_date"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "assignor_id"
    t.integer  "resource_id"
    t.integer  "company_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "department_id"
  end

  add_index "tasks", ["assignor_id"], :name => "index_tasks_on_assignor_id"

  create_table "tasks_users", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "user_contacts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.boolean  "connected",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "user_contacts", ["contact_id"], :name => "index_user_contacts_on_contact_id"
  add_index "user_contacts", ["user_id"], :name => "index_user_contacts_on_user_id"

  create_table "user_settings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "search_city"
    t.integer  "search_state"
    t.integer  "search_zip_code"
    t.integer  "time_zone"
    t.boolean  "privacy",         :default => true
    t.string   "username"
    t.boolean  "account_status",  :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "department_id"
    t.string   "status"
    t.integer  "role_id"
    t.integer  "company_id"
    t.string   "avatar_content_type"
    t.string   "avatar_file_name"
    t.integer  "avatar_file_size"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "logged_in",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
