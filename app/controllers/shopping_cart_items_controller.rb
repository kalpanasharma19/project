class ShoppingCartItemsController < ApplicationController
  before_action :shopping_cart_item

  def show
  end

  def create
    selected_product = Product.find_by(id: params[:product_id])

    if @shopping_cart_item = current_customer.shopping_cart_items.find_by(product_id: selected_product)
      @shopping_cart_item.increment(:quantity)
    else
      @shopping_cart_item = current_customer.shopping_cart_items.new

      @shopping_cart_item.product = selected_product
      @shopping_cart_item.quantity = 1
    end

    if @shopping_cart_item.save
      flash[:success] = "Product added to cart."
      redirect_to products_path
    else
      flash[:alert] = "Error while adding"
    end
  end

  def add_quantity
    @shopping_cart_item.increment(:quantity)
    @shopping_cart_item.save
    respond_to do |f|
      f.html { redirect_to shopping_cart_items_show_path }
      f.js
    end
  end

  def reduce_quantity
    shopping_cart_item.decrement(:quantity) if shopping_cart_item.quantity > 1
    shopping_cart_item.save
    respond_to do |f|
      f.html { redirect_to shopping_cart_items_show_path }
      f.js { redirect_to shopping_cart_items_show_path }
    end
  end

  def destroy
    @item = current_customer.shopping_cart_items.find_by(id: params[:id])
    @item.destroy
    respond_to do |f|
      f.html { redirect_to shopping_cart_items_show_path }
      f.js { redirect_to shopping_cart_items_show_path }
    end
  end

  private

  def shopping_cart_item
     @shopping_cart_item ||= ShoppingCartItem.find_by(id: params[:id])
  end
end
