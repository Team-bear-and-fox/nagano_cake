class Public::ItemsController < ApplicationController
 def index
  @item = Item.all
  @items = Item.all.page(params[:page]).per(8)
  @items_sale = @items.select do |item|
    item.is_on_sale == true
  end
  @genres = Genre.all
 end

 def show
  @item = Item.find(params[:id])
  @genres = Genre.all
 end
end