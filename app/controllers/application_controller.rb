class ApplicationController < ActionController::Base
  before_action :set_current_customer, unless: :admin_url
  before_action :authenticate_admin!, if: :admin_url

  def set_current_customer
    @current_customer = Customer.find_by(id: session[:customer_id])
  end

  def authenticate_customer
    if @current_customer == nil
      redirect_to ("/")
    end
  end

  def admin_url
    request.fullpath.include?("/admin")
  end
end
