class Public::HomesController < ApplicationController
 def top
  items = Item.all
  # @items = Item.order(created_at: :desc).limit(4)
  @new_items = items.sort_by { |item| item.created_at }.reverse.first(4)
 end
end