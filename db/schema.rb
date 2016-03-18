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

ActiveRecord::Schema.define(version: 20160317232856) do

  create_table "answers", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
    t.text     "text"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.boolean  "attended"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",  default: false
  end

  add_index "attendances", ["user_id", "lesson_id"], name: "index_attendances_on_user_id_and_lesson_id", unique: true

  create_table "codewars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
  end

  create_table "device_tokens", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_posts", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "school_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "job_posts", ["school_id"], name: "index_job_posts_on_school_id"

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "venue_id"
    t.text     "summary"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "notification_sent_at"
    t.string   "tweet_message"
    t.integer  "teacher_id"
    t.string   "image_social"
    t.string   "codewars_challenge_slug"
    t.string   "codewars_challenge_language"
    t.string   "hangout_url"
    t.string   "archive_url"
  end

  add_index "lessons", ["slug"], name: "index_lessons_on_slug", unique: true

  create_table "polls", force: :cascade do |t|
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  create_table "prosperity_dashboards", force: :cascade do |t|
    t.string   "title",      null: false
    t.boolean  "default",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timezone"
    t.integer  "day_of_week"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
  end

  add_index "user_answers", ["user_id", "answer_id"], name: "index_user_answers_on_user_id_and_answer_id", unique: true

  create_table "user_badges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                          default: "",   null: false
    t.string   "encrypted_password",             default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                  default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "subscribe_lesson_notifications", default: true
    t.boolean  "admin"
    t.boolean  "teacher"
    t.string   "unsubscribe_token"
    t.boolean  "hide_last_name",                 default: true
    t.string   "homepage"
    t.string   "github_username"
    t.integer  "school_id"
    t.datetime "last_badges_checked_at"
    t.boolean  "subscribe_badge_notifications",  default: true
    t.string   "codewars_username"
    t.datetime "last_codewars_checked_at"
    t.string   "bridge_troll_user_id",           default: ""
    t.integer  "rails_bridge_class_count",       default: 0
  end

  add_index "users", ["bridge_troll_user_id"], name: "index_users_on_bridge_troll_user_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["rails_bridge_class_count"], name: "index_users_on_rails_bridge_class_count"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["school_id"], name: "index_users_on_school_id"

  create_table "venues", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gmaps"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.integer  "school_id"
    t.string   "comment"
    t.string   "slug"
  end

end
