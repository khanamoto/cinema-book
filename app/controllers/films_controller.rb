class FilmsController < ApplicationController
  def show
  end

  def new
    @film = Film.new
    # 関連オブジェクトを生成
    @film.tags.build
  end

  def create
    @film = Film.new(film_params)
    if @film.save
      redirect_to :index
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def film_params
    params.require(:film).permit(:title, :staff, :comment, :favorite_scene, :cinema, :watch_day, :film_image, tags_attributes: [:tag_name])
  end
end
