class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!,{only: [:index, :create, :edit, :update, :destroy]}
  def index
    @address = Address.new
    @addresses = Address.all.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to request.referer
    else
       @addresses = Address.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
     render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to request.referer
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
