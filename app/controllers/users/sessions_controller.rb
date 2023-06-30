class Users::SessionsController < Devise::SessionsController
  def guest_login
    user = User.guest
    session[:user_id] = user.id
    sign_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to user_path(user)
  end
end
