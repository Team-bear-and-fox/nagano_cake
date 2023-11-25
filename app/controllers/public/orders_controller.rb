class Public::OrdersController < ApplicationController
before_action :authenticate_customer!,{only: [:new, :confirm, :create, :complete, :index, :show]}


  def new
    @order = Order.new
    @customer = current_customer
    @cart_items = @customer.cart_items
    if @cart_items.empty?
      flash[:notice] = "カートの中身がありません"
      redirect_to cart_items_path and return
    end
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @cart_items = @customer.cart_items
    @postage = 800
    @cart_items_total = @cart_items.inject(0) { |sum, item| sum + item.add_sub_total }
    @payment_total = @postage + @cart_items_total

    if params[:order][:address_type] == "customer_address"
      @order.address = @customer.address
      @order.postal_code = @customer.postal_code
      @order.name = @customer.last_name + @customer.first_name
    elsif params[:order][:address_type] == "registered_address"
      address = Address.find_by(id: params[:order][:address_id])
      if address
        @order.address = address.address
        @order.postal_code = address.postal_code
        @order.name = address.name
      else
        flash.now[:alert] = "配送先住所を選択してください"
        render :new
      end
    elsif params[:order][:address_type] == "create_new_address"
      @order.address = params[:order][:new_address]
      @order.postal_code = params[:order][:new_postal_code]
      @order.name = params[:order][:new_name]
      if @order.address.blank? || @order.postal_code.blank? || @order.name.blank?
        flash.now[:alert] = "新しいお届け先の全ての項目を入力してください"
        render :new
      end
    else
      flash.now[:alert] = "お届け先を選択してください"
      render :new
    end
  end

  def create
    session[:order_info] = order_params
    @order = current_customer.orders.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "credit_card"
      @order.order_status = 1
    end
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.value = cart_item.item.add_tax_value
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(createdat: :desc)
  end

  def show

    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @total_item_amount = @order_details.sum { |order_detail| order_detail.add_sub_total }
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :payment_method, :payment_total, :order_status, :name, :postal_code, :address)
  end
end

