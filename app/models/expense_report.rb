# frozen_string_literal: true

class ExpenseReport < ApplicationRecord
  belongs_to :customer
  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :synced_with_zoho, inclusion: { in: [true, false] }
end
