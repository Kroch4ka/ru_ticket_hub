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

<<<<<<< Updated upstream
ActiveRecord::Schema[7.1].define(version: 2024_08_18_071346) do
=======
ActiveRecord::Schema[7.1].define(version: 2024_08_25_101912) do
  create_table "clients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "inn", null: false
    t.string "verify_callback_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inn"], name: "index_companies_on_inn", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "type"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.integer "ticket_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_messages_on_ticket_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "description", null: false
    t.integer "priority", default: 0, null: false
    t.string "aasm_state"
    t.integer "client_id", null: false
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_tickets_on_client_id"
    t.index ["employee_id"], name: "index_tickets_on_employee_id"
  end

>>>>>>> Stashed changes
  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "profile_type"
    t.integer "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_type", "profile_id"], name: "index_users_on_profile"
  end

<<<<<<< Updated upstream
=======
  add_foreign_key "employees", "companies"
  add_foreign_key "messages", "tickets"
  add_foreign_key "messages", "users"
  add_foreign_key "tickets", "clients"
  add_foreign_key "tickets", "employees"
>>>>>>> Stashed changes
end
