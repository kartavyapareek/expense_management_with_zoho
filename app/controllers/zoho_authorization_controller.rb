# frozen_string_literal: true

class ZohoAuthorizationController < ApplicationController
  def redirect
    redirect_to ZohoAuthorizationService.new.authorization_url, allow_other_host: true
  end

  def callback
    response = ZohoAuthorizationService.new.save_tokens(params[:code])
    render plain: response
  end
end
