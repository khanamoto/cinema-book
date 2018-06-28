class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      # DBにトークンを格納する
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'パスワード再設定用のメールを送信しました。'
      redirect_to new_password_reset_url
    else
      flash.now[:danger] = 'メールアドレスが見つかりませんでした。'
      render :new
    end
  end

  def edit
  end

  def update
    # パスワードが空ならエラーを表示する
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render :edit
    # 正しいパスワードなら更新する
    elsif @user.update_attributes(user_params)
      flash[:success] = 'パスワードを再設定しました。'
      redirect_to sessions_new_url
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # 正しいユーザーかどうか確認する
  def valid_user
    unless (@user && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'パスワード再設定URLの有効期限が切れています。'
      redirect_to new_password_reset_url
    end
  end
end
