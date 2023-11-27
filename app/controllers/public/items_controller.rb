class Public::ItemsController < ApplicationController
 def index
  @items_sale = Item.where(is_on_sale: true).page(params[:page]).per(8)
  @genres = Genre.all
 end

 def show
  @item = Item.find(params[:id])
  @genres = Genre.all
 end
end