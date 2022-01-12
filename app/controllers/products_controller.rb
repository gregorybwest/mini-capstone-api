class ProductsController < ApplicationController
  def display_product
    render json: Product.all
  end
end
