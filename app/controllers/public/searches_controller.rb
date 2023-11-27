class Public::SearchesController < ApplicationController
  def genre_search
    @item = Item.all
    @genre_id = params[:genre_id]
    @genres = Genre.all
    @genre_name =Genre.find(params[:genre_id])
    @items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
    @items_sale = @items.where(is_on_sale: true).page(params[:page]).per(8)
  end
end
