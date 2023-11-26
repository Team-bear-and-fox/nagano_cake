class SearchesController < ApplicationController
  def search
    @item = Item.looks(params[:search], params[:word])
    redirect_to items_path
  end
end
