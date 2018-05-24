class ApplicationController < ActionController::Base
  # before_action :basic_auth
  before_action :set_current_user

  private
  def basic_auth
    # 認証に使うユーザ名とパスワードは環境変数に書く
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV["BASIC_AUTH_USER"] && Digest::SHA1.hexdigest(pass) == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user])
  end
end
