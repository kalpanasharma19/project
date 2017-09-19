class CustomersController < ApplicationController
  skip_before_action :authenticate_customer, only: [:new, :create]
  before_action :save_login_state, only: [:new, :create]
  before_action :valid_customer, except: [:index, :show]
  before_action :check_admin, only: [:index]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find_by(id: params[:id])
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find_by(id: params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to products_path
    else
      render "new"
    end

  end

  def update
    @customer = Customer.find_by(id: params[:id])
    if @customer.update_attributes(customer_params)
      redirect_to customer_path(@customer)
    else
      render "edit"
    end
  end

  def destroy
    @customer = Customer.find_by(id: params[:id])
    @customer.destroy
    redirect_to customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end

  def valid_customer
    return true if Customer.find_by(id: params[:id]) == current_customer
    flash[:alert] = "You can edit your details only!"
    redirect_to customers_path
  end

  def check_admin
    redirect_to customer_path(current_customer) unless is_admin?
  end
end
