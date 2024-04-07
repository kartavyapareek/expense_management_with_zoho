# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :expense_reports, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true
  validates :synced_with_zoho, inclusion: { in: [true, false] }
end
