class UsersController < ApplicationController
  include SessionsHelper

  before_action :check_logined
  before_action :correct_user, only: [:edit, :update, :destroy, :password, :change_password]
  before_action :set_user, only: [:edit, :update, :destroy, :password, :change_password]

  def show
    @films = Film.where(user_id: params[:id]).order(created_at: :desc).page(params[:page]).per(10)

    # サイドバーに表示するユーザーを取得する
    @user = User.find_by(id: params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path, notice: 'ユーザー情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    reset_session
    redirect_to new_registration_url
  end

  def password
  end

  def change_password
    # フィールドの値を取得
    @user.attributes = user_password_params
    # シンボルを使い、検証するコンテキストを定義する
    if @user.save(context: :change_password)
      redirect_to password_user_path, notice: 'パスワードを変更しました'
    else
      render :password
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :profile_name, :email, :profile, :user_image)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
