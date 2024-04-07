# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.boolean :synced_with_zoho, default: false
      t.integer :zoho_id
      t.index :zoho_id, unique: true
      t.index :name, unique: true # create unique index on name because zoho requires unique names
      t.timestamps
    end
  end
end
