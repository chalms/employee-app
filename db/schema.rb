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

ActiveRecord::Schema.define(version: 20140616055143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: true do |t|
    t.integer  "manager_id", null: false
    t.integer  "worker_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chats", ["manager_id", "worker_id"], name: "index_chats_on_manager_id_and_worker_id", unique: true, using: :btree

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "geo_locations_id"
  end

  create_table "equipment", force: true do |t|
    t.string   "description",      null: false
    t.string   "barcode"
    t.text     "photo"
    t.string   "part_name",        null: false
    t.integer  "report_id",        null: false
    t.integer  "report_index"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "geo_locations_id"
  end

  create_table "geo_locations", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "managers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "content"
    t.boolean  "delivered"
    t.integer  "chat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipient"
    t.boolean  "read"
  end

  create_table "reports", force: true do |t|
    t.string   "description"
    t.date     "report_date",                 null: false
    t.datetime "checkin"
    t.datetime "checkout"
    t.boolean  "completed",   default: false
    t.integer  "manager_id",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "worker_id",                   null: false
    t.integer  "clients_id"
  end

  create_table "tasks", force: true do |t|
    t.string   "description"
    t.boolean  "completed"
    t.datetime "completed_at"
    t.string   "note"
    t.text     "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "report_id"
    t.integer  "report_index"
    t.integer  "geo_locations_id"
  end

  create_table "users", force: true do |t|
    t.string "role",                              null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email",                default: "", null: false
    t.string "encrypted_password",   default: "", null: false
    t.string "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "workers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
