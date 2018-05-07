class ApplicationController < ActionController::Base
  before_action :basic_auth

  private
  def basic_auth
    # 認証に使うユーザ名とパスワードは環境変数に書く
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV["BASIC_AUTH_USER"] && Digest::SHA1.hexdigest(pass) == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
