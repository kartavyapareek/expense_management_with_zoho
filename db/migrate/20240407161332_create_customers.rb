# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.boolean :synced_with_zoho, default: false
      t.integer :zoho_id
      t.timestamps
    end
  end
end
