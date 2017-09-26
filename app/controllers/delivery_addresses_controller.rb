class DeliveryAddressesController < ApplicationController
  before_action :valid_customer

  def create
    @delivery_address = current_customer.delivery_addresses.create(delivery_address_params)
    flash[:alert] = @delivery_address.errors.full_messages
    redirect_to customer_path(current_customer)
  end


  def destroy
    @delivery_address = current_customer.delivery_addresses.find_by(id: params[:id])
    @delivery_address.destroy
    redirect_to customer_path(current_customer)
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
