class RegistrationsController < ApplicationController
  def new
    # フォームの器となる空のオブジェクトを生成
    @user = User.new
  end
end
