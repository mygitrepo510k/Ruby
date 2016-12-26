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

ActiveRecord::Schema.define(version: 20140522173043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "program_id"
    t.integer  "created_by_id"
    t.boolean  "hidden",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "announcements", ["program_id"], name: "index_announcements_on_program_id", using: :btree

  create_table "challenge_frames", force: true do |t|
    t.text     "note"
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "private",          default: false
    t.integer  "content_group_id"
    t.integer  "again_by_id"
    t.datetime "again_at"
    t.string   "filepicker_url"
    t.string   "s3_key"
    t.string   "thumbnail_url"
  end

  add_index "challenge_frames", ["user_id", "challenge_id"], name: "index_challenge_frames_on_user_id_and_challenge_id", unique: true, using: :btree

  create_table "challenges", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "created_by_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "content_group_id"
    t.datetime "due"
    t.string   "cover"
    t.boolean  "deleted",          default: false
    t.boolean  "special",          default: false
    t.string   "thumbnail_url"
    t.string   "filepicker_url"
  end

  create_table "challenges_pods", id: false, force: true do |t|
    t.integer  "challenge_id"
    t.integer  "pod_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges_user_programs", id: false, force: true do |t|
    t.integer  "challenge_id"
    t.integer  "user_program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",          default: false
    t.integer  "program_id"
    t.string   "scope"
  end

  add_index "comments", ["program_id"], name: "index_comments_on_program_id", using: :btree

  create_table "content_group_items", force: true do |t|
    t.integer  "content_group_id"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_group_items", ["content_group_id", "content_id"], name: "index_content_group_items_on_content_group_id_and_content_id", unique: true, using: :btree

  create_table "content_groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",       default: false
  end

  create_table "content_groups_nodes", id: false, force: true do |t|
    t.integer "content_group_id"
    t.integer "content_node_id"
  end

  create_table "content_nodes", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_tags", force: true do |t|
    t.integer  "content_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_tags", ["content_id"], name: "index_content_tags_on_content_id", using: :btree
  add_index "content_tags", ["tag_id"], name: "index_content_tags_on_tag_id", using: :btree

  create_table "contents", force: true do |t|
    t.string   "name"
    t.integer  "created_by_id"
    t.text     "description"
    t.text     "url"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wistia_id"
    t.integer  "content_type",   default: 0
    t.boolean  "deleted",        default: false
    t.string   "image"
    t.text     "player_embed"
    t.string   "filepicker_url"
    t.string   "s3_key"
    t.string   "option"
    t.integer  "month"
    t.integer  "program_id"
    t.integer  "tag_id"
  end

  add_index "contents", ["program_id"], name: "index_contents_on_program_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "event_attendees", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "status"
    t.datetime "rsvped"
    t.integer  "guest_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_attendees", ["user_id", "event_id"], name: "index_event_attendees_on_user_id_and_event_id", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.string   "icon"
    t.string   "cover"
    t.text     "place_name"
    t.string   "place_id"
    t.integer  "program_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "host_id"
    t.boolean  "deleted",       default: false
    t.text     "description"
  end

  create_table "experience_followers", force: true do |t|
    t.integer  "user_id"
    t.integer  "experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experience_followers", ["user_id", "experience_id"], name: "index_experience_followers_on_user_id_and_experience_id", unique: true, using: :btree

  create_table "experiences", force: true do |t|
    t.string   "name"
    t.integer  "created_by_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_for_id"
    t.boolean  "deleted",               default: false
    t.datetime "executed_at"
    t.integer  "frame_id"
    t.integer  "executed_by_id"
    t.boolean  "made_private",          default: false
    t.boolean  "private"
    t.datetime "scheduled_for"
    t.text     "what_came_up"
    t.integer  "color"
    t.text     "emergent"
    t.integer  "feel_seen"
    t.text     "go_deeper"
    t.text     "looking_to_open"
    t.text     "process"
    t.text     "possible_difficulties"
    t.text     "how_to_handle"
  end

  create_table "likes", force: true do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.integer  "by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likeable_id", "likeable_type", "by_id"], name: "index_likes_on_likeable_id_and_likeable_type_and_by_id", unique: true, using: :btree

  create_table "locations", force: true do |t|
    t.string "name"
  end

  create_table "pods", force: true do |t|
    t.integer  "leader_id"
    t.integer  "program_id"
    t.string   "name"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    default: false
  end

  create_table "posts", force: true do |t|
    t.text     "body"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "by_id"
    t.datetime "bumped"
    t.boolean  "deleted",        default: false
    t.string   "filepicker_url"
    t.string   "s3_key"
    t.string   "wistia_id"
    t.text     "player_embed"
    t.boolean  "pinned",         default: false
  end

  add_index "posts", ["program_id"], name: "index_posts_on_program_id", using: :btree

  create_table "programs", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "hub_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "welcome_email"
    t.boolean  "deleted",               default: false
    t.integer  "root_content_node_id"
    t.string   "welcome_email_subject"
    t.boolean  "has_content",           default: true
  end

  create_table "tags", force: true do |t|
    t.string   "tag_type"
    t.string   "name"
    t.integer  "added_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_forms", force: true do |t|
    t.integer  "typeform_id"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form"
    t.integer  "response_id"
    t.integer  "user_id"
    t.integer  "program_id"
  end

  create_table "user_programs", force: true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pod_id"
    t.integer  "role",           default: 0
    t.integer  "safeword",       default: 0
    t.boolean  "private_intake", default: false
  end

  add_index "user_programs", ["user_id", "program_id"], name: "index_user_programs_on_user_id_and_program_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "super_admin"
    t.string   "timezone"
    t.text     "bio"
    t.string   "avatar"
    t.integer  "hub_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier_url"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "current_program_id"
    t.string   "tagline"
    t.date     "birthday"
    t.string   "gender"
    t.string   "job"
    t.boolean  "deleted",                default: false
    t.text     "hub"
    t.boolean  "activated",              default: false
    t.integer  "location_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
