class ProductsController < ApplicationController

  before_action :authenticate_admin, except: [:index, :show]

  def index
    products = Product.all
    if params[:search]
      products = products.where("name iLike '%#{params[:search]}%'")
    end
    if params[:sort] == "price"
      products = products.order(:price)
    end
    if params[:sort_order]
      products = products.order(price: :desc)
    end
    # products = products.order(:id)
    if params[:category]
      category = Category.find_by(name: params[:category])
      products = category.products
    end
    render json: products
  end

  def create
    product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      inventory: params[:inventory]
    )
    if product.save
      render json: product
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    product = Product.find(params[:id])
    render json: {product: product, current_user: current_user}
  end

  def update
    # use segment parameter to find product
    product = Product.find(params[:id])
    # update unless nill passed in 
    product.name = params[:name] || product.name
    product.price = params[:price] || product.price
    product.description = params[:description] || product.description
    #save the changes
    if product.save
      render json: product
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: {message: "Product successfully destroyed!"}
  end

end
