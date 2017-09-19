class OrdersController < ApplicationController
  before_action :valid_order, only: [:new, :create]
  before_action :valid_quantity_of_items, only: [:new, :create]

  def show
  end

  def new
    @delivery_address = current_customer.delivery_addresses.find_by(id: params[:delivery_address_id])
  end

  def create
    order = current_customer.orders.create(order_params)

    current_customer.shopping_cart_items.each do |item|
      order_item = add_order_item(item, order)
      order_item.save
      reduce_stock_quantity(item)
      item.destroy
    end
    if order.save
      flash[:success] = "Order confirmed!"
      redirect_to products_path
    end
  end

  def destroy
    @order = current_customer.orders.find_by(id: params[:id]) rescue nil
    @order.destroy
    render 'show'
  end

  private

  def order_params
    params.require(:order).permit(:delivery_address_id)
  end

  def reduce_stock_quantity(item)
    @product = Product.find_by_id(item.product.id)
      @product.stock_quantity -= item.quantity
       @product.save
  end

  def valid_order
    if current_customer.shopping_cart_items.count == 0
      flash[:success] = "Please add products to cart!"
      redirect_to products_path
    end
  end

  def valid_quantity_of_items
    current_customer.shopping_cart_items.each do |item|
      @product = Product.find_by_id(item.product.id)
      if @product.stock_quantity < item.quantity
        flash[:notice] = "quantity exceeded!"
        redirect_to products_path
      end
    end
  end

  def add_order_item(item, order)
    order_item = OrderItem.new
    order_item.order = order
    order_item.product_id = item.product.id
    order_item.price = item.product.price
    order_item.quantity = item.quantity
    return order_item
  end
end
