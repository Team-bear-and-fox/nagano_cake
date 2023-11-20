class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    # @book_comment = current_user.book_comments.find_by(book_id: @item.id)
    @cart_items = CartItem.all
  end

  def create
    
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.item_id = @item.id
    binding.pry
    @cart_item.save
    redirect_to cart_items_path
  end
  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
