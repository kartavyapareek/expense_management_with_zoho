# frozen_string_literal: true

class CustomerSyncWorker
  include Sidekiq::Worker

  def perform
    Customer.where(synced_with_zoho: false).find_each do |customer|
      sync_customer_with_zoho(customer)
    end
  end

  private

  def sync_customer_with_zoho(customer)
    response = ZohoOperationService.new.create_customer(customer)
    next unless response.code == 201

    customer.update(zoho_id: response['customer_id'], synced_with_zoho: true) if response['customer_id']
    puts "Syncing customer with Zoho: #{customer.name}"
  end
end
