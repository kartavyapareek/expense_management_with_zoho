# frozen_string_literal: true

class ZohoOperationService
  def initalise
    @client_id = ENV.fetch('ZOHO_CLIENT_ID')
    @client_secret = ENV.fetch('ZOHO_CLIENT_SECRET')
    @redirect_uri = ENV.fetch('ZOHO_REDIRECT_URL')
    @access_token = ZohoToken.last.valid_access_token
  end

  def create_customer(customer)
    url = "#{ENV.fetch('ZOHO_API_BASE_URL')}/books/v3/customers?organization_id=#{ENV.fetch('ZOHO_ORGANIZATION_ID')}"
    headers = { Authorization: "Zoho-oauthtoken #{@access_token}", content_type: 'application/json' }
    body = {
      contact_name: customer.name,
      customer_name: customer.name,
      contact_type: 'customer'
    }
    response = HTTParty.post(url, headers:, body: body.to_json)
    return 'Customer created successfully' if response.code == 200

    response
  end

  def create_expense_report(expense_report)
    url = "#{ENV.fetch('ZOHO_AUTH_API_BASE_URL')}/books/v3/expense-reports?organization_id=#{ENV.fetch('ZOHO_ORGANIZATION_ID')}"
    headers = { Authorization: "Zoho-oauthtoken #{@access_token}", content_type: 'application/json' }
    body = {
      customer_id: expense_report.customer.zoho_id,
      title: expense_report.title,
      description: expense_report.description,
      amount: expense_report.amount
    }
    response = HTTParty.post(url, headers:, body: body.to_json)
    return 'Expense report created successfully' if response.code == 200

    response
  end

  def fetch_customer(customer_id)
    url = "#{ENV.fetch('ZOHO_AUTH_API_BASE_URL')}/books/v3/customers/#{customer_id}"
    headers = { Authorization: "Zoho-oautohtoken #{@access_token}", content_type: 'application/json' }
    response = HTTParty.get(url, headers:)
    return JSON.parse(response.body) if response.code == 200

    response
  end

  def fetch_expense_report(expense_report_id)
    url = "#{ENV.fetch('ZOHO_AUTH_API_BASE_URL')}/books/v3/expense-reports/#{expense_report_id}"
    headers = { Authorization: "Zoho-oauthtoken #{@access_token}", content_type: 'application/json' }
    response = HTTParty.get(url, headers:)
    return JSON.parse(response.body) if response.code == 200

    response
  end
end
