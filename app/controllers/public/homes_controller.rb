class Public::HomesController < ApplicationController
 def top
  @items_all = Item.all
  @items_sale = @items_all.select do |item|
   item.is_on_sale == true
  end
  @items = @items_sale.sort_by(&:created_at).reverse.first(4)
  @genres = Genre.all
 end
end