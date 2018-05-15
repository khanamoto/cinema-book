class SessionsController < ApplicationController
  def new
    if session[:user] then
      redirect_to :root
    end
  end

  # /login
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) then
      reset_session
      session[:user] = user.id
      # 隠しフィールドにセットしたページへ
      redirect_to params[:referer]
    else
      # 失敗した場合は、flash[:referer]を再セット
      flash.now[:referer] = params[:referer]
      @error = 'メールアドレスまたはパスワードをご確認ください'
      render :new
    end
  end

  # /logout
  def destroy
    reset_session
    redirect_to '/sessions/new'
  end
end
