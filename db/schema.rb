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

ActiveRecord::Schema[8.0].define(version: 2025_09_08_041736) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "daily_tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "goal_id", null: false
    t.string "title", null: false
    t.date "date", null: false
    t.boolean "done", default: false, null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_daily_tasks_on_goal_id"
    t.index ["user_id", "goal_id", "date"], name: "index_daily_tasks_on_user_id_and_goal_id_and_date"
    t.index ["user_id"], name: "index_daily_tasks_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "target_date"
    t.integer "progress"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "sub_goals", force: :cascade do |t|
    t.bigint "goal_id", null: false
    t.string "title", null: false
    t.date "due_on"
    t.integer "progress", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["due_on"], name: "index_sub_goals_on_due_on"
    t.index ["goal_id"], name: "index_sub_goals_on_goal_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_tasks", "goals"
  add_foreign_key "daily_tasks", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "sub_goals", "goals"
end
