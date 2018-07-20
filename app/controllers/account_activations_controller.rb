class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # モデルから有効化する
      user.activate
      log_in user
      flash[:success] = 'アカウントが有効化されました'
      redirect_to root_url
    else
      flash[:danger] = 'リンクが無効です'
      redirect_to root_url
    end
  end
end
