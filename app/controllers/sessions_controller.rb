class SessionsController < ApplicationController
  layout 'index'

  def new
    if session[:user] then
      redirect_to :root
    end
  end

  # /login
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.activated?
      reset_session
      log_in user
      # 隠しフィールドにセットしたページへ
      redirect_to params[:referer]
    else
        message = 'アカウントが有効化されていません。Filmsからお送りしたメールを確認し、アカウントを有効化してください'
        flash[:warning] = message
        redirect_to sessions_new_url
      end
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
