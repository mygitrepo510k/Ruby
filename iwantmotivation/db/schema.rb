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

ActiveRecord::Schema.define(:version => 20130617150438) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.integer  "kind",        :default => 0, :null => false
    t.integer  "sort_id",     :default => 0, :null => false
    t.integer  "parent_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "chat_conversations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chat_messages", :force => true do |t|
    t.text     "body"
    t.string   "subject"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "chat_conversation_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "coachcounselors", :force => true do |t|
    t.integer  "user_id"
    t.string   "really_name"
    t.text     "philosophy"
    t.text     "experience"
    t.text     "helppeople"
    t.text     "license"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "coachcounselors", ["user_id"], :name => "index_coachcounselors_on_user_id"

  create_table "conversation_metadata", :force => true do |t|
    t.integer  "chat_conversation_id"
    t.integer  "user_id"
    t.boolean  "archived",             :default => false
    t.boolean  "read",                 :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "conversation_metadata", ["chat_conversation_id"], :name => "index_conversation_metadata_on_chat_conversation_id"
  add_index "conversation_metadata", ["user_id"], :name => "index_conversation_metadata_on_user_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "foundus", :force => true do |t|
    t.string   "found_us_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "channel"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.boolean  "ispublic"
    t.string   "moderator"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "invites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "inviter_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invites", ["group_id"], :name => "index_invites_on_group_id"
  add_index "invites", ["user_id"], :name => "index_invites_on_user_id"

  create_table "member_groups", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "member_groups", ["group_id"], :name => "index_member_groups_on_group_id"
  add_index "member_groups", ["user_id"], :name => "index_member_groups_on_user_id"

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

  create_table "options", :force => true do |t|
    t.string   "option_name"
    t.text     "option_value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "stores", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.string   "author"
    t.decimal  "price",          :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "sell_price",     :precision => 8, :scale => 2, :default => 0.0
    t.text     "content"
    t.text     "affiliate_code"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

  add_index "stores", ["category_id"], :name => "index_stores_on_category_id"

  create_table "user_categories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_categories", ["category_id"], :name => "index_user_categories_on_category_id"
  add_index "user_categories", ["user_id"], :name => "index_user_categories_on_user_id"

  create_table "user_infos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "age"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "discount_code"
    t.text     "motivational_partner"
    t.text     "philosophy_on_life"
    t.text     "my_story"
    t.text     "books_enjoyed"
    t.text     "other_groups"
    t.text     "groups_belong_to"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "user_infos", ["user_id"], :name => "index_user_infos_on_user_id"

  create_table "user_options", :force => true do |t|
    t.string   "name"
    t.string   "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "foundus_id"
    t.integer  "user_option_id"
    t.string   "email",                                                              :default => "",    :null => false
    t.string   "encrypted_password",                                                 :default => ""
    t.decimal  "amount",                               :precision => 8, :scale => 2, :default => 0.0
    t.string   "payment_token"
    t.string   "identifier"
    t.boolean  "transaction_cleared",                                                :default => false
    t.string   "name"
    t.string   "ismember"
    t.boolean  "logged_in",                                                          :default => false, :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                                                            :null => false
    t.datetime "updated_at",                                                                            :null => false
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
