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

ActiveRecord::Schema.define(version: 20140706025208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_locations", force: true do |t|
    t.integer "client_id"
    t.integer "location_id"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "time_of_retrieval"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "content"
    t.boolean  "delivered"
    t.boolean  "read"
    t.integer  "chat_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts", force: true do |t|
    t.string  "part_name"
    t.string  "barcode"
    t.boolean "scanned",   default: false
  end

  create_table "photos", force: true do |t|
    t.text     "data"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.string   "description"
    t.integer  "location_id"
    t.boolean  "completed",   default: false
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.date     "report_date"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "task_parts", force: true do |t|
    t.integer "task_id"
    t.integer "part_id"
  end

  add_index "task_parts", ["task_id", "part_id"], name: "index_task_parts_on_task_id_and_part_id", using: :btree

  create_table "task_photos", force: true do |t|
    t.integer "task_id"
    t.integer "photo_id"
  end

  add_index "task_photos", ["task_id", "photo_id"], name: "index_task_photos_on_task_id_and_photo_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "note"
    t.integer  "report_id"
    t.string   "description"
    t.integer  "report_index"
    t.boolean  "completed",    default: false
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_chats", force: true do |t|
    t.integer  "user_id"
    t.integer  "chat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_chats", ["user_id", "chat_id"], name: "index_user_chats_on_user_id_and_chat_id", using: :btree

  create_table "user_reports", force: true do |t|
    t.integer "user_id"
    t.integer "report_id"
  end

  add_index "user_reports", ["user_id", "report_id"], name: "index_user_reports_on_user_id_and_report_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company_name"
    t.string   "api_secret"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "password"
    t.string   "auth_token"
  end

end
