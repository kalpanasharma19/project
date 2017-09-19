class WelcomeController < ApplicationController
  skip_before_action :authenticate_customer, only: [:index]
  def index
  end
end
