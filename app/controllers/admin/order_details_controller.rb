class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all

    is_updated = true
    if @order_detail.update(order_detail_params)
      @order.update(order_status: 'now_making') if @order_detail.production_status == 'in_production'
      @order_details.each do |order_detail|
        if order_detail.production_status != 'production_complete'
          is_updated = false
        end
      end
      @order.update(order_status: 'preparing_for_shipment') if is_updated
      redirect_to admin_order_path(@order.id)
    else
      render "admin/orders/show"
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end