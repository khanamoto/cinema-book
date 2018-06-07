module SessionsHelper
  # ログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == @current_user
  end
end
