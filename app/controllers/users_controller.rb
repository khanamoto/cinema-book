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
end
