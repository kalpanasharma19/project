class ApplicationController < ActionController::Base
  before_action :authenticate_customer
  protect_from_forgery with: :exception
  include CustomersHelper
  helper_method :is_admin?, :current_customer

  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) rescue nil
  end

  def is_admin?
    current_customer.admin? rescue nil
  end

  protected
  def authenticate_customer
    if session[:customer_id]
      # set current customer object to @current_customer object variable
      @current_customer = Customer.find(session[:customer_id])
      return true
    else
      redirect_to new_session_path
    end
  end

  def save_login_state
    redirect_to products_path if session[:customer_id]
  end
end
