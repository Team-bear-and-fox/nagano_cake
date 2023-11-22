class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    # @order_details = OrderDetail.where(order_id: @order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :payment_method, :payment_total, :order_status, :name, :postal_code, :address)
  end
end
