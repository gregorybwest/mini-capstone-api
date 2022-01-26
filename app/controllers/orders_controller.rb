class OrdersController < ApplicationController
  
  def index
    if current_user
      orders = current_user.orders
      render json: orders
    else
      render json: [], status: :unauthorized 
    end
  end
  
  def create
    if current_user
      product = Product.find(params[:product_id])
      subtotal = product.price * params[:quantity]
      tax = subtotal * 0.09
      total = subtotal + tax
      order = Order.new(
        product_id: params[:product_id],
        user_id: current_user.id,
        quantity: params[:quantity],
        subtotal: params[:subtotal],
        tax: params[:tax],
        total: params[:total]
      )
      order.save
      render json: order
    else
      render json: [], status: :unauthorized 
    end
  end

  def show
    order = Order.find(params[:id])
    if order.user_id == current_user.id
      render json: order
    else
      render json: {errors: order.errors.full_messages}, status: :unprocessable_entity
    end
  end


    

end
