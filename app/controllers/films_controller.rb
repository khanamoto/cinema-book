class FilmsController < ApplicationController
  before_action :check_logined
  before_action :set_film, only: [:show, :edit, :update, :destroy]

  def new
    @film = Film.new
    # 関連オブジェクトを生成
    # @film.tags.build
  end

  def create
    @film = Film.new(film_params)
    @film.user_id = @current_user.id

    if @film.save
      redirect_to films_path
    else
      render :new
    end
  end

  def index
    @films = Film.where(user_id: @current_user).order(updated_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @film.update(film_params)
      redirect_to films_path
    else
      render :edit
    end
  end

  def destroy
    @film.destroy
    redirect_to films_path
  end

  private
  def set_film
    @film = Film.find(params[:id])
  end

  def film_params
    params.require(:film).permit(:title, :staff, :comment, :favorite_scene, :cinema, :watch_day, :film_image)#, tags_attributes: [:tag_name])
  end
end
