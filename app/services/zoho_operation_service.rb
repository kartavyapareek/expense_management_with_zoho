# frozen_string_literal: true

class ZohoOperationService
  def initalise
    @client_id = ENV.fetch('ZOHO_CLIENT_ID')
    @client_secret = ENV.fetch('ZOHO_CLIENT_SECRET')
    @redirect_uri = ENV.fetch('ZOHO_REDIRECT_URL')
    @access_token = ZohoToken.last.access_token
  end

  def create_customer(customer)
    url = "#{ENV.fetch('ZOHO_API_BASE_URL')}/books/v3/customers"
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
end
