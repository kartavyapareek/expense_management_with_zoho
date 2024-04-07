# frozen_string_literal: true

class ExpenseReportsController < ApplicationController
  before_action :set_customer
  before_action :set_expense_report, only: %i[show update destroy]

  # GET /customers/:customer_id/expense_reports
  def index
    @expense_reports = @customer&.expense_reports

    if @expense_reports.empty?
      render json: { message: 'No expense reports found' }, status: :not_found
    else
      render json: @expense_reports
    end
  end

  # GET /customers/:customer_id/expense_reports/1
  def show
    render json: @expense_report
  end

  # POST /customers/:customer_id/expense_reports
  def create
    @expense_report = @customer.expense_reports.new(expense_report_params)

    if @expense_report.save
      render json: @expense_report, status: :created, location: [@customer, @expense_report]
    else
      render json: @expense_report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/:customer_id/expense_reports/1
  def update
    if @expense_report.update(expense_report_params)
      render json: @expense_report
    else
      render json: @expense_report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/:customer_id/expense_reports/1
  def destroy
    @expense_report.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_expense_report
    @expense_report = @customer.expense_reports.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_report_params
    params.require(:expense_report).permit(:customer, :title, :description, :amount)
  end
end
