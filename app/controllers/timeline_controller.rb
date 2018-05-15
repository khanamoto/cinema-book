class TimelineController < ApplicationController
  before_action :check_logined

  private
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
end
