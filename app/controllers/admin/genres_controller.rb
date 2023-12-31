class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルを追加しました。"
      redirect_to request.referer
    else
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "変更が完了しました。"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
