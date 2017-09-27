class DeliveryAddressesController < ApplicationController
  before_action :valid_customer

  def create
    @delivery_address = current_customer.delivery_addresses.create(delivery_address_params)
    flash[:alert] = @delivery_address.errors.full_messages
    respond_to do |f|
        f.html { redirect_to customer_path(current_customer) }
        f.json { render json: @delivery_address }
      end
  end


  def destroy
    @delivery_address = current_customer.delivery_addresses.find_by(id: params[:id])
    if @delivery_address.destroy
      respond_to do |f|
        f.html { redirect_to customer_path(current_customer) }
        f.json { render json: @delivery_address }
      end
    else
      flash[:alert] = "Found error while removing..."
    end
  end

  private
  def delivery_address_params
    params.require(:delivery_address).permit(:name, :address, :phone_number)
  end

  def valid_customer
    return true if Customer.find_by(id: params[:customer_id]) == current_customer
    flash[:alert] = "You can edit your details only!"
    redirect_to customer_path(current_customer)
  end
end
