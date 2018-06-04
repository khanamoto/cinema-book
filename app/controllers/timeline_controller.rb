class TimelineController < ApplicationController
  before_action :check_logined

  def index
    @films = Film.all.order(updated_at: :desc).page(params[:page]).per(10)
  end
end
