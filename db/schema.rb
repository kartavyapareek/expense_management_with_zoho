# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_240_407_161_348) do
  create_table 'customers', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.integer 'zoho_customer_id_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['zoho_customer_id_id'], name: 'index_customers_on_zoho_customer_id_id'
  end

  create_table 'expense_reports', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.integer 'amount'
    t.integer 'customer_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_expense_reports_on_customer_id'
  end

  create_table 'zoho_tokens', force: :cascade do |t|
    t.string 'access_token'
    t.string 'refresh_token'
    t.integer 'expires_in'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'customers', 'zoho_customer_ids'
  add_foreign_key 'expense_reports', 'customers'
end
