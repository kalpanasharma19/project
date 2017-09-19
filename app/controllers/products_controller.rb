class ProductsController < ApplicationController
  skip_before_action :authenticate_customer, only: [:index, :show]
  before_action :check_admin, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new

  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find_by(id: params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:image, :name, :description, :price, :stock_quantity)
  end

  def check_admin
    return true if is_admin?
    redirect_to root_url
  end
end
