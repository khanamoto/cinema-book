class UsersController < ApplicationController
  before_action :check_logined
  before_action :set_user, only: [:edit, :update, :destroy, :password, :change_password]

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
  end

  def password
  end

  def change_password
    # パスワード入力が空の場合、blankオプションでエラーメッセージを表示する
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render :password
    elsif @user.update(user_password_params)
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
    params.require(:user).permit(:user_name, :profile_name, :email, :profile)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
