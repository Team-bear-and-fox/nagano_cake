class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @cart_items = @customer.cart_items
    @postage = 800
    @cart_items_total = @cart_items.inject(0) { |sum, item| sum + item.add_sub_total }
    @payment_total = @postage + @cart_items_total
    @address_type = params[:order][:address_type]

    if params[:order][:address_type] == "customer_address"
      @order.address = @customer.address
      @order.postal_code = @customer.postal_code
      @order.name = @customer.last_name + @customer.first_name
    elsif params[:order][:address_type] == "registered_address"
      address = Address.find_by(id: params[:order][:address_id])
      @order.address = address.address
      @order.postal_code = address.postal_code
      @order.name = address.name
    elsif params[:order][:address_type] == "create_new_address"
      @order.address = params[:order][:new_address]
      @order.postal_code = params[:order][:new_postal_code]
      @order.name = params[:order][:new_name]
    end

    # if @order.new_address.blank? || @order.new_postal_code.blank? || @order.new_name.blank?
    #   flash[:alert] = "新しいお届け先の入力に不備があります"
    #   render :new
    # end
  end

  def create
    @order = current_customer.orders.new(order_params)
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
    # else
    #   flash.now[:notice] = ""


    # @order = Order.new
    # @order.customer_id = current_customer.id
    # @order.postage = 800
    # @cart_items = CartItem.where(customer_id: current_customer.id)

    # prices = []
    # @cart_items.each do |cart_item|
    #   prices << cart_item.item.value*cart_item.amount
    # end

    # @cart_items_total = prices.sum
    # @order.payment_total = @order.postage + @cart_items_total
    # @order.payment_method = params[:order][:payment_method]
    # if @order.payment_method == "credit_card"
    #   @order.status = 1
    # else
    #   @order.status = 0
    # end

    # address_type = params[:order][:address_type]
    # case address_type
    # when "customer_address"
    #   @order.postal_code = current_customer.postal_code
    #   @order.address = current_customer.address
    #   @order.name = current_customer.last_name + current_customer.first_name

    # when "registered_address"
    #   Address.find(params[:order][:regestered_address_id])
    #   # ↑この行要る？
    #   selected = Address.find(params[:order][:registered_address_id])
    #   @order.postal_code = selected.postal_code
    #   @order.address = selected.address
    #   @order.name = selected.name

    # when "create_new_address"
    #   @order.postal_code = params[:order][:new_postal_code]
    #   @order.address = params[:order][:new_address]
    #   @order.name = params[:order][:new_name]
    # end

    # if @order.save

    #   if @order.status == 0
    #     @cart_items.each do |cart_item|
    #       OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, value: cart_item.item.value, amount: cart_item.amount, production_status: 0)
    #     end
    #   else
    #     @cart_items.each do |cart_item|
    #       OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, value: cart_item.item.value, amount: cart_item.amount, production_status: 1)
    #     end
    #   end

    #   @cart_items.destroy_all
    #   redirect_to complete_orders_path

    # else
    #   render :items
    # end
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(createdat: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :payment_method, :payment_total, :order_status, :name, :postal_code, :address)

  end


end
