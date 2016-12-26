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

ActiveRecord::Schema.define(:version => 20130906112526) do

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

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "unit"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.integer  "country_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "immutable"
    t.integer  "addressable_id"
    t.string   "addressable_type"
  end

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
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admin_users_roles", :id => false, :force => true do |t|
    t.integer "admin_user_id"
    t.integer "role_id"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "clinics", :force => true do |t|
    t.string "name"
    t.string "phone"
    t.string "website"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "code"
  end

  add_index "countries", ["code"], :name => "index_countries_on_code"

  create_table "doctor_claims", :force => true do |t|
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "doctor_patients", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "user_id"
    t.integer  "status",             :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "email"
    t.string   "health_card_number"
    t.string   "invitation_token"
  end

  create_table "doctors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.string   "speciality"
    t.string   "physician_id"
    t.integer  "status"
    t.integer  "clinic_id"
    t.integer  "gender"
  end

  create_table "dosages", :force => true do |t|
    t.integer  "quantity"
    t.integer  "unit"
    t.integer  "frequency"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kc_pages", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "html"
    t.integer  "sort_order"
    t.boolean  "published"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "visible_to_doctors"
    t.boolean  "visible_to_patients"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "medicine_id"
    t.decimal  "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "order_id"
    t.integer  "quantity"
    t.integer  "unit"
  end

  create_table "medicines", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.decimal  "price"
    t.integer  "unit"
  end

  create_table "notification_settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "receive_message"
    t.boolean  "has_news"
    t.boolean  "has_tagged_me"
    t.boolean  "receive_prescription"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "notification_settings", ["user_id"], :name => "index_notification_settings_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "notification_type"
    t.text     "parameters"
    t.integer  "user_id"
    t.boolean  "read"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "url"
  end

  create_table "orders", :force => true do |t|
    t.integer  "status"
    t.datetime "placed_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.decimal  "sub_total"
    t.decimal  "tax"
    t.string   "taxname"
    t.decimal  "total"
    t.integer  "shipping_address_id"
    t.integer  "user_id"
    t.integer  "prescription_id"
    t.integer  "payment_status"
    t.string   "tracking_number"
    t.integer  "processed_by_id"
  end

  create_table "payment_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "auto_renew"
  end

  create_table "payments", :force => true do |t|
    t.integer  "order_id"
    t.string   "charge_id"
    t.integer  "operation"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "success"
  end

  create_table "prescriptions", :force => true do |t|
    t.text     "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "prescription_image_file_name"
    t.string   "prescription_image_content_type"
    t.integer  "prescription_image_file_size"
    t.datetime "prescription_image_updated_at"
    t.string   "symptom"
    t.integer  "user_id"
    t.integer  "dosage_id"
    t.integer  "item_id"
    t.integer  "administration_method_id"
    t.date     "expiration"
    t.integer  "status"
    t.integer  "medicine_id"
    t.string   "doctor_name"
    t.date     "issue_date"
    t.string   "current_usage_habits"
    t.integer  "doctor_id"
    t.integer  "doctor_patient_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "health_card_number"
    t.string   "phone"
    t.date     "date_of_birth"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "reason_description"
    t.integer  "gender"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "admin"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
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
    t.boolean  "profile_updated",        :default => false
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "refill_reminder"
    t.datetime "expire_reminder"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
