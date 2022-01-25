class SuppliersController < ApplicationController
  def index
    suppliers = Supplier.all
    render json: suppliers
  end

  # def create
  #   supplier = Supplier.new(
  #     name: params[:name],
  #     email: params[:email],
  #     phone_number: params[:phone_number],
  #   )
  #   supplier.save
  #   render json: 
  # end

end
