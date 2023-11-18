class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    customer = current_customer
    customer.update
    redirect_to mypage_customer_path(customer)
  end
  
end
