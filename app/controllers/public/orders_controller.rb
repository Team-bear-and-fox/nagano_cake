class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items#CartItem.where(customer_id: current_customer.id)
    @postage = 800
    @payment_method = params[:order][:payment_method]
    prices = []

    @cart_items.each do |cart_item|
      prices << cart_item.item.value*cart_item.amount
    end

    @cart_items_total = prices.sum
    @payment_total = @postage + @cart_items_total
    @address_type = params[:order][:address_type]

    case @address_type
    when "customer_address"
      @selected_address = current_customer.postal_code + "　" + current_customer.address + "　" + current_customer.last_name + "　" + current_customer.first_name

    when "registered_address"
      unless params[:order][:registered_address_id] == ""
        selected = Address.find(params[:order][:registered_address_id])
        @selected_address = selected.postal_code + "　" + selected.address + "　" + selected.name
      else
        render :new
      end

    when "create_new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_address = params[:order][:new_postal_code] + "　" + params[:order][:new_address] + "　" + params[:order][:new_name]
      else
        render :new
      end
    end
  end


  def create
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.postage = 800
    @cart_items = CartItem.where(customer_id: current_customer.id)

    prices = []
    @cart_items.each do |cart_item|
      prices << cart_item.item.value*cart_item.amount
    end

    @cart_items_total = prices.sum
    @order.payment_total = @order.postage + @cart_items_total
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "credit_card"
      @order.status = 1
    else
      @order.status = 0
    end

    address_type = params[:order][:address_type]
    case address_type
    when "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    when "registered_address"
      Address.find(params[:order][:regestered_address_id])
      # ↑この行要る？
      selected = Address.find(params[:order][:registered_address_id])
      @order.postal_code = selected.postal_code
      @order.address = selected.address
      @order.name = selected.name

    when "create_new_address"
      @order.postal_code = params[:order][:new_postal_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_name]
    end

    if @order.save

      if @order.status == 0
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, value: cart_item.item.value, amount: cart_item.amount, production_status: 0)
        end
      else
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, value: cart_item.item.value, amount: cart_item.amount, production_status: 1)
        end
      end

      @cart_items.destroy_all
      redirect_to complete_orders_path

    else
      render :items
    end
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

end
