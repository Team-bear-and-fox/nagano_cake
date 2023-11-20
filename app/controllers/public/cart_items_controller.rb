class Public::CartItemsController < ApplicationController
  def index
    @cart_items=CartItem.find(params[:id])
    
  end

  def create
    redirect_to cart_items_path
  end
end
