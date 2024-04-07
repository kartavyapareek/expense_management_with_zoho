# frozen_string_literal: true

class ZohoToken < ApplicationRecord
  def valid_access_token
    refresh if expired?

    access_token
  end

  def expired?
    expires_in > Time.now.to_i
  end

  def refresh
    ZohoAuthorizationService.new.refresh_access_token

    ZohoToken.last.access_token if ZohoToken.last.expires_in > Time.now.to_i
  end
end
