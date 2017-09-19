class SessionsController < ApplicationController
  skip_before_action :authenticate_customer, only: [:new, :create]
  before_action :save_login_state, only: [:new, :create]

  def new
  end

  def create
    authorized_customer = Customer.authenticate(params[:username], params[:login_password])

    if authorized_customer
      session[:customer_id] = authorized_customer.id
      redirect_to products_path
    else
      render "new"
    end
  end

  def destroy
    session.destroy
    render 'new'
  end
end
