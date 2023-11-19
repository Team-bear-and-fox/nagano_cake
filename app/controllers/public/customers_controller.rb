class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    customer = current_customer
    if customer.update
      redirect_to mypage_customer_path(customer)
    else
      render :edit
    end
  end
  
  def confirm
    
  end
  
  def withdraw
    customer = current_customer
    customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end
  
end
