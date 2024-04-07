# frozen_string_literal: true

class ZohoAuthorizationService
  def authorization_url
    url = "#{ENV.fetch('ZOHO_API_BASE_URL')}/oauth/v2/auth"
    params = "scope=ZohoBooks.fullaccess.all&client_id=#{ENV.fetch('ZOHO_CLIENT_ID')}&" \
             "response_type=code&redirect_uri=#{ENV.fetch('ZOHO_REDIRECT_URL')}&access_type=offline&prompt=consent"
    "#{url}?#{params}"
  end

  def save_tokens(code)
    client_id = ENV.fetch('ZOHO_CLIENT_ID')
    client_secret = ENV.fetch('ZOHO_CLIENT_SECRET')
    redirect_uri = ENV.fetch('ZOHO_REDIRECT_URL')
    grant_type = 'authorization_code'
    url = "https://accounts.zoho.in/oauth/v2/token?code=#{code}&client_id=#{client_id}&client_secret=#{client_secret}&redirect_uri=#{redirect_uri}&grant_type=#{grant_type}"
    response = HTTParty.post(url)
    return 'No token found' unless response['access_token'].present?

    ZohoToken.create(access_token: response['access_token'], refresh_token: response['refresh_token'],
                     expires_in: convert_expires_in_to_time(response['expires_in']))
    'Tokens saved now you can use the apis.'
  end

  def refresh_access_token
    client_id = ENV.fetch('ZOHO_CLIENT_ID')
    client_secret = ENV.fetch('ZOHO_CLIENT_SECRET')
    refresh_token = ZohoToken.last.refresh_token
    grant_type = 'refresh_token'
    url = "https://accounts.zoho.in/oauth/v2/token?refresh_token=#{refresh_token}&client_id=#{client_id}&client_secret=#{client_secret}&grant_type=#{grant_type}"
    response = HTTParty.post(url)
    return 'No token found' unless response['access_token'].present?

    ZohoToken.last.update(access_token: response['access_token'], refresh_token: response['refresh_token'],
                          expires_in: convert_expires_in_to_time(response['expires_in']))
    'Token refreshed'
  end

  def convert_expires_in_to_time(expires_in)
    Time.now.to_i + expires_in.to_i
  end
end
