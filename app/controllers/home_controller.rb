# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    return unless ZohoToken.last.present?

    render json: { message: 'Welcome to the Integration. Please use the api to create customer and expense' }
  end
end
