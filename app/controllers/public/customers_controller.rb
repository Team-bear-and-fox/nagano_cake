class Public::CustomersController < ApplicationController
  before_action :authenticate_customer,{only: [:show, :edit, :update, :confirm, :withdraw]}

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    if customer.update(customer_params)
      flash[:notice] = "変更が完了しました。"
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
    redirect_to root_path,notice: "退会処理を実行しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :phone_number, :postal_code, :address)
  end

end
