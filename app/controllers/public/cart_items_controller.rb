class Public::CartItemsController < ApplicationController
 before_action :authenticate_customer!,{only: [:destroy, :destroy_all, :create, :index, :update]}
 def index
  @cart_items = current_customer.cart_items.all
  @total = @cart_items.inject(0) { |sum, item| sum + item.add_sub_total}
 end

 def create
  @item = Item.find(cart_item_params[:item_id])
  @cart_item = current_customer.cart_items.new(cart_item_params)
  @cart_item.customer_id = current_customer.id
  @cart_item.item_id = @item.id
  @cart_items = current_customer.cart_items.all
  save_successful = false
  @cart_items.each do |cart_item|
   if cart_item.item_id == @cart_item.item_id
    if @cart_item.amount
     new_amount = cart_item.amount + @cart_item.amount
     cart_item.update_attribute(:amount, new_amount)
     @cart_item.delete
     save_successful = true
    end
   end
  end
  if @cart_item.save
   flash[:notice] = "カートに商品が追加されました。"
   save_successful = true
  end
  redirect_based_on_save_status(save_successful)
 end

 def update
  @cart_item = CartItem.find(params[:id])
  if @cart_item.update(cart_item_params)
   redirect_to cart_items_path(@cart_item.id)
  else
   render :index
  end
 end

 def destroy
  @cart_item = CartItem.find(params[:id])
  @cart_item.destroy
  redirect_to cart_items_path
 end

 def destroy_all
  @cart_items = current_customer.cart_items
  @cart_items.destroy_all
  redirect_to cart_items_path,notice: "カートに商品がありません。"
 end
 private

 def cart_item_params
   params.require(:cart_item).permit(:item_id, :amount)
 end

 def redirect_based_on_save_status(save_successful)
  if save_successful
   redirect_to cart_items_path
  else
   @item = Item.find(cart_item_params[:item_id])
   redirect_to item_path(@item.id)
  end
 end
end