class TimelineController < ApplicationController
  def index
    # 検索結果一覧を取得する
    @films = Film.all.order(created_at: :desc).page(params[:page]).per(10).search(params[:search])
    # 検索件数を取得する
    @films_count = Film.search(params[:search]).count
  end
end
