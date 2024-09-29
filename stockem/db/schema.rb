# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_29_051902) do
  create_table "events", force: :cascade do |t|
    t.string "event_id"
    t.integer "item_id", null: false
    t.string "event_type"
    t.integer "associated_user_id", null: false
    t.integer "associated_student_id"
    t.string "location"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "associated_student_id" ], name: "index_events_on_associated_student_id"
    t.index [ "associated_user_id" ], name: "index_events_on_associated_user_id"
    t.index [ "item_id" ], name: "index_events_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "item_id"
    t.string "serial_number"
    t.string "item_name"
    t.string "category"
    t.integer "quality_score"
    t.boolean "currently_available"
    t.string "image"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "note_id"
    t.integer "item_id", null: false
    t.string "msg"
    t.integer "user_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "item_id" ], name: "index_notes_on_item_id"
    t.index [ "user_id" ], name: "index_notes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id"
    t.string "name"
    t.string "uin"
    t.string "email"
    t.string "contact_no"
    t.string "role"
    t.string "details"
    t.integer "auth_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "items"
  add_foreign_key "events", "users", column: "associated_student_id"
  add_foreign_key "events", "users", column: "associated_user_id"
  add_foreign_key "notes", "items"
  add_foreign_key "notes", "users"
end
