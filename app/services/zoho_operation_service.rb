# frozen_string_literal: true

class ZohoOperationService
  def initalise
    @client_id = ENV.fetch('ZOHO_CLIENT_ID')
    @client_secret = ENV.fetch('ZOHO_CLIENT_SECRET')
    @redirect_uri = ENV.fetch('ZOHO_REDIRECT_URL')
    @access_token = ZohoToken.last.valid_access_token
  end

  def create_customer(customer)
    url = "#{ENV.fetch('ZOHO_API_BASE_URL')}/books/v3/contacts?organization_id=#{ENV.fetch('ZOHO_ORGANIZATION_ID')}"
    headers = { 'Authorization' => "Zoho-oauthtoken #{@access_token}", 'Content-Type' => 'application/json' }
    body = {
      contact_name: customer.name,
      contact_type: 'customer'
    }
    response = HTTParty.post(url, headers:, body: body.to_json)
    return 'Customer created successfully' if response.code == 201

    response
  end

  def create_expense_report(expense_report)
    url = "#{ENV.fetch('ZOHO_API_BASE_URL')}/books/v3/expenses?organization_id=#{ENV.fetch('ZOHO_ORGANIZATION_ID')}"
    headers = { 'Authorization' => "Zoho-oauthtoken #{@access_token}", 'Content-Type' => 'application/json' }
    body = {
      customer_id: expense_report.customer.zoho_id.to_s,
      # TODO: need to make account_id dynamic ( need to provide all ids or name in the api doc )
      account_id: '1805250000000000516',
      date: expense_report.created_at.strftime('%Y-%m-%d'),
      amount: expense_report.amount
    }
    response = HTTParty.post(url, headers:, body: body.to_json)
    return 'Expense report created successfully' if response.code == 201

    response
  end

  def fetch_customer(customer_id)
    url = "#{ENV.fetch('ZOHO_API_BASE_URL')}/books/v3/customers/#{customer_id}"
    headers = { 'Authorization' => "Zoho-oauthtoken #{@access_token}", 'Content-Type' => 'application/json' }
    response = HTTParty.get(url, headers:)
    return JSON.parse(response.body) if response.code == 200

    response
  end

  def fetch_expense_report(expense_report_id)
    url = "#{ENV.fetch('ZOHO_API_BASE_URL')}/books/v3/expenses/#{expense_report_id}"
    headers = { 'Authorization' => "Zoho-oauthtoken #{@access_token}", 'Content-Type' => 'application/json' }
    response = HTTParty.get(url, headers:)
    return JSON.parse(response.body) if response.code == 200

    response
  end
end
