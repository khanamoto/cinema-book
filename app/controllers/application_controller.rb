class ApplicationController < ActionController::Base
  include SessionsHelper

  # before_action :basic_auth
  before_action :set_current_user

  private
  def basic_auth
    # 認証に使うユーザ名とパスワードは環境変数に書く
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV["BASIC_AUTH_USER"] && Digest::SHA1.hexdigest(pass) == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def check_logined
    if session[:user] then
      begin
        @user = User.find(session[:user])
      rescue ActiveRecord::RecordNotFound
        # ユーザー情報がない場合は、不正なアクセスとみなしセッションを破棄
        reset_session
      end
    end

    # ユーザー情報を取得できなかった場合は、ログインページへ
    unless @user
      # ログインに成功した時、元の要求ページにリダイレクトさせるためリクエストURLをセット
      flash[:referer] = request.fullpath
      redirect_to controller: :sessions, action: :new
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user])
  end
end
