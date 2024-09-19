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

ActiveRecord::Schema[7.1].define(version: 2024_09_15_155335) do
  create_table "access_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_access_tokens_on_account_id"
    t.index ["token"], name: "index_access_tokens_on_token", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "body", null: false
    t.integer "author_id", null: false
    t.integer "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_messages_on_author_id"
    t.index ["ticket_id"], name: "index_messages_on_ticket_id"
  end

  create_table "operators", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "profileable_type"
    t.string "profileable_id"
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_profiles_on_account_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "subject", null: false
    t.text "body", null: false
    t.string "status"
    t.integer "operator_id"
    t.integer "profile_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_tickets_on_company_id"
    t.index ["operator_id"], name: "index_tickets_on_operator_id"
    t.index ["profile_id"], name: "index_tickets_on_profile_id"
  end

  add_foreign_key "access_tokens", "accounts"
  add_foreign_key "messages", "profiles", column: "author_id"
  add_foreign_key "messages", "tickets"
  add_foreign_key "profiles", "accounts"
  add_foreign_key "tickets", "companies"
  add_foreign_key "tickets", "operators"
  add_foreign_key "tickets", "profiles"
end
