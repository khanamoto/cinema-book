class UsersController < ApplicationController
  before_action :check_logined
  before_action :set_user, only: [:edit, :update, :destroy, :password]

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
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :profile_name, :email, :profile)
  end
end
