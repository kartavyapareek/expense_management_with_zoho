# frozen_string_literal: true

class CreateExpenseReports < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_reports do |t|
      t.string :title
      t.string :description
      t.integer :amount, default: 0
      t.boolean :synced_with_zoho, default: false
      t.integer :zoho_id
      t.references :customer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
