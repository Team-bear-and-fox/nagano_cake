class Public::CartItemsController < ApplicationController
  def index
  end

  def create
    redirect_to cart_items_path
  end
end
