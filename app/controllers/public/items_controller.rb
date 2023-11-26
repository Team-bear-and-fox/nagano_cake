class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @item = Item.page(params[:page]).per(8)
    @select_genre_name = '商品'
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def genre
    @genres = Genre.all
    @select_genre_name = genre.find(params[:id]).name
    @items = Item.all
    @item = Item.where(genre_id: params[:id], is_active: true).page(params[:page])
  end
end
