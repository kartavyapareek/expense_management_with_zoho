# frozen_string_literal: true

class ZohoDataFetchController < ApplicationController
  def fetch_customer_data
    response = ZohoOperationService.new.fetch_customer(params[:customer_id])
    render json: response
  end

  def fetch_expense_report_data
    response = ZohoOperationService.new.fetch_expense_report(params[:expense_report_id])
    render json: response
  end
end
