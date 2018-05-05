class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/'
    else
      flash[:alert] = '登録に失敗しました。もう一度やり直してください。'
      render 'registrations/new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :profile_name, :email, :password)
  end
end
