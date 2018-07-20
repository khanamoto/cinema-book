class RegistrationsController < ApplicationController
  layout 'index'

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
      # モデルからメール送信する
      @user.send_activation_email
      flash[:info] = 'アカウント有効化のメールをお送りしましたのでご確認ください'
      log_in @user
      redirect_to root_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :agree)
  end
end
