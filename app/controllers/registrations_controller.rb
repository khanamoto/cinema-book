class RegistrationsController < ApplicationController
  layout 'index'

  def index
    redirect_to action: 'new'
  end

  def new
    if session[:user] then
      redirect_to :root
    end

    # フォームの器となる空のオブジェクトを生成
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :root
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :agree)
  end
end
