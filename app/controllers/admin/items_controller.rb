class Admin::ItemsController < ApplicationController
  
  def new
    @item = Item.new
    @genre = Genre.pluck(:genre_id)
    @genre = 
  end 
  
  def create
    item = Item.new(item_params)
    item.save
    redirect_to admin_item_path
  end
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :explanation, :value, :genre_id, :is_on_sale)
  end
  
end
