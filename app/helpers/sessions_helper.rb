module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user] = user.id
  end

  # ログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == @current_user
  end
end
