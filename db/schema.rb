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

ActiveRecord::Schema[7.1].define(version: 2024_04_07_161348) do
  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.boolean "synced_with_zoho", default: false
    t.integer "zoho_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_customers_on_name", unique: true
    t.index ["zoho_id"], name: "index_customers_on_zoho_id", unique: true
  end

  create_table "expense_reports", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "amount", default: 0
    t.boolean "synced_with_zoho", default: false
    t.integer "zoho_id"
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_expense_reports_on_customer_id"
  end

  create_table "zoho_tokens", force: :cascade do |t|
    t.string "access_token"
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expense_reports", "customers"
end
