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

ActiveRecord::Schema.define(version: 20140710094049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "complete",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "company_id"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "company_admin"
    t.boolean  "complete",      default: false
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "name"
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_logs", force: true do |t|
    t.integer "company_id"
    t.string  "name"
    t.string  "employee_number"
    t.string  "role"
  end

  create_table "locations", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "locations_reports", force: true do |t|
    t.integer "location_id"
    t.integer "report_id"
  end

  create_table "locations_reports_parts", force: true do |t|
    t.integer "location_id"
    t.integer "reports_part_id"
  end

  create_table "locations_reports_tasks", force: true do |t|
    t.integer "location_id"
    t.integer "reports_task_id"
  end

  create_table "locations_users_reports", force: true do |t|
    t.integer "location_id"
    t.integer "users_report_id"
  end

  create_table "messages", force: true do |t|
    t.text     "data"
    t.integer  "photo_id"
    t.integer  "user_id"
    t.integer  "chat_id"
    t.boolean  "read_by_all", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts", force: true do |t|
    t.string  "name"
    t.string  "barcode"
    t.integer "user_id"
    t.integer "client_id"
    t.integer "company_id"
    t.integer "project_id"
  end

  create_table "photos", force: true do |t|
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
    t.integer  "reports_part_id"
    t.integer  "reports_task_id"
  end

  add_index "photos", ["message_id"], name: "index_photos_on_message_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "budget"
    t.boolean  "complete",   default: false
    t.integer  "company_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manager_id"
  end

  create_table "projects_users", force: true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "reports", force: true do |t|
    t.string  "summary"
    t.date    "date"
    t.boolean "complete",   default: false
    t.integer "client_id"
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "reports_parts", force: true do |t|
    t.boolean  "complete"
    t.boolean  "false"
    t.string   "note"
    t.datetime "completion_time"
    t.integer  "part_id"
    t.integer  "users_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports_tasks", force: true do |t|
    t.boolean  "complete"
    t.boolean  "false"
    t.string   "note"
    t.datetime "completion_time"
    t.integer  "tasks_id"
    t.integer  "users_reports_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string  "description"
    t.integer "client_id"
    t.integer "user_id"
    t.integer "company_id"
    t.integer "project_id"
  end

  create_table "tasks_projects", force: true do |t|
    t.integer "project_id"
    t.integer "task_id"
  end

  add_index "tasks_projects", ["task_id", "project_id"], name: "index_tasks_projects_on_task_id_and_project_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "employee_number"
    t.binary   "password"
    t.string   "api_secret"
    t.string   "type"
    t.string   "auth_token"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "contact_id"
  end

  create_table "users_chats", force: true do |t|
    t.integer "user_id"
    t.integer "chat_id"
  end

  add_index "users_chats", ["user_id", "chat_id"], name: "index_users_chats_on_user_id_and_chat_id", using: :btree

  create_table "users_messages", force: true do |t|
    t.integer "user_id"
    t.integer "message_id"
    t.boolean "read",       default: false
  end

  add_index "users_messages", ["user_id", "message_id"], name: "index_users_messages_on_user_id_and_message_id", using: :btree

  create_table "users_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "report_id"
    t.datetime "checkin"
    t.datetime "checkout"
    t.boolean  "complete",    default: false
    t.integer  "location_id"
    t.integer  "manager_id"
  end

  add_index "users_reports", ["user_id", "report_id"], name: "index_users_reports_on_user_id_and_report_id", using: :btree

end
