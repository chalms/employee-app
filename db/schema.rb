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

ActiveRecord::Schema.define(version: 20140614011418) do

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

  create_table "location_clients", force: true do |t|
    t.integer "location_id"
    t.integer "client_id"
  end

  add_index "location_clients", ["location_id", "client_id"], name: "index_location_clients_on_location_id_and_client_id", using: :btree

  create_table "location_report_parts", force: true do |t|
    t.integer "location_id"
    t.integer "report_part_id"
  end

  add_index "location_report_parts", ["location_id", "report_part_id"], name: "index_location_report_parts_on_location_id_and_report_part_id", using: :btree

  create_table "location_report_tasks", force: true do |t|
    t.integer "location_id"
    t.integer "report_task_id"
  end

  add_index "location_report_tasks", ["location_id", "report_task_id"], name: "index_location_report_tasks_on_location_id_and_report_task_id", using: :btree

  create_table "location_reports", force: true do |t|
    t.integer "location_id"
    t.integer "report_id"
  end

  add_index "location_reports", ["location_id", "report_id"], name: "index_location_reports_on_location_id_and_report_id", using: :btree

  create_table "location_user_reports", force: true do |t|
    t.integer "location_id"
    t.integer "user_report_id"
  end

  add_index "location_user_reports", ["location_id", "user_report_id"], name: "index_location_user_reports_on_location_id_and_user_report_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "report_part_id"
    t.integer  "report_task_id"
  end

  add_index "photos", ["message_id"], name: "index_photos_on_message_id", using: :btree

  create_table "project_users", force: true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

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
  end

  create_table "report_parts", force: true do |t|
    t.boolean  "complete"
    t.boolean  "false"
    t.string   "note"
    t.datetime "completion_time"
    t.integer  "part_id"
    t.integer  "user_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_tasks", force: true do |t|
    t.boolean  "complete"
    t.boolean  "false"
    t.string   "note"
    t.datetime "completion_time"
    t.integer  "tasks_id"
    t.integer  "user_reports_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.string  "summary"
    t.date    "date"
    t.boolean "complete",   default: false
    t.integer "client_id"
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "task_projects", force: true do |t|
    t.integer "project_id"
    t.integer "task_id"
  end

  add_index "task_projects", ["task_id", "project_id"], name: "index_task_projects_on_task_id_and_project_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string  "description"
    t.integer "client_id"
    t.integer "user_id"
    t.integer "company_id"
    t.integer "project_id"
  end

  create_table "user_chats", force: true do |t|
    t.integer "user_id"
    t.integer "chat_id"
  end

  add_index "user_chats", ["user_id", "chat_id"], name: "index_user_chats_on_user_id_and_chat_id", using: :btree

  create_table "user_messages", force: true do |t|
    t.integer "user_id"
    t.integer "message_id"
    t.boolean "read",       default: false
  end

  add_index "user_messages", ["user_id", "message_id"], name: "index_user_messages_on_user_id_and_message_id", using: :btree

  create_table "user_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "report_id"
    t.datetime "checkin"
    t.datetime "checkout"
    t.boolean  "complete",    default: false
    t.integer  "location_id"
  end

  add_index "user_reports", ["user_id", "report_id"], name: "index_user_reports_on_user_id_and_report_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "employee_number"
    t.binary   "password"
    t.string   "api_secret"
    t.string   "type"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "contact_id"
  end

end
