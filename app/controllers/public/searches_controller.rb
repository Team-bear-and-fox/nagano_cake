class Public::SearchesController < ApplicationController
  def genre_search
    @genre_id = params[:genre_id]
    @genres = Genre.all
    @genre_name =Genre.find(params[:genre_id])
    @item = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
    @items = Item.all
  end
end
