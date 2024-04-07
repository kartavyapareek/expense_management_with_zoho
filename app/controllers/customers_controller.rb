# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show]

  # GET /customers
  def index
    @customers = Customer.all

    if @customers.empty?
      render json: { message: 'No customers found' }, status: :not_found
    else
      render json: @customers
    end
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:name, :email)
  end
end
