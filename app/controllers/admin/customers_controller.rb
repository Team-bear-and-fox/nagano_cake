class Admin::CustomersController < ApplicationController
  def show
    @customer=Customer.find(params[:id])
  end
  def index
    @customers = Customer.page(params[:page]).per(2)
  end
  def edit
    @customer=Customer.find(params[:id])
  end
  def update
    @customer=Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer),notice: 'Customer was successfully updated.'
  end


  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:phone_number,:postal_code,:address,:is_active,:email)
  end
end
