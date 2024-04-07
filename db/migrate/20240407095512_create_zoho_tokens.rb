# frozen_string_literal: true

class CreateZohoTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :zoho_tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_in
      t.timestamps
    end
  end
end
