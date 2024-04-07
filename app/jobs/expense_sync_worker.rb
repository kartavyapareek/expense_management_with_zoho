# frozen_string_literal: true

class ExpenseSyncWorker
  include Sidekiq::Worker

  def perform
    Expense.where(synced_with_zoho: true).find_each do |expense|
      sync_expense_with_zoho(expense)
    end
  end

  private

  def sync_expense_with_zoho(expense)
    response = ZohoOperationService.new.create_expense_report(expense)
    next unless response.code == 201

    expense.update(zoho_id: response.fetch('expense', 'expense_id'), synced_with_zoho: true) if response['expense']
    puts "Syncing expense with Zoho: #{expense.name}"
  end
end
