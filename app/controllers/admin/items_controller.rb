class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def index
    @items = Item.all
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :value, :genre_id, :is_on_sale, :image)
  end

end
