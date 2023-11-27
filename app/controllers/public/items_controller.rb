class Public::ItemsController < ApplicationController
 def index
  @items = Item.all
  @items_sale = @items.select do |item|
    item.is_on_sale == true
  end
  @item = Item.page(params[:page]).per(8)
  @genres = Genre.all
 end

 def show
  @item = Item.find(params[:id])
  @genres = Genre.all
 end
end