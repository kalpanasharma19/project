class ShoppingCartItemsController < ApplicationController
  def show
  end

  def new
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
      redirect_to shopping_cart_items_show_path
    else
      render 'new'
    end
  end

  def add_quantity
    shopping_cart_item.increment(:quantity)
    shopping_cart_item.save
    redirect_to shopping_cart_items_show_path
  end

  def reduce_quantity
    shopping_cart_item.decrement(:quantity) if shopping_cart_item.quantity > 1
    shopping_cart_item.save
    redirect_to shopping_cart_items_show_path
  end

  def destroy
    @item = current_customer.shopping_cart_items.find_by(id: params[:id])
    @item.destroy
    redirect_to shopping_cart_items_show_path
  end

  private

  def shopping_cart_item
     @shopping_cart_item ||= ShoppingCartItem.find_by(id: params[:id])
  end
end
