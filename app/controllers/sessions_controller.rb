class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login(user)
      redirect_to user
    else
      flash.now[:danger] = "ログインに失敗しました"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
