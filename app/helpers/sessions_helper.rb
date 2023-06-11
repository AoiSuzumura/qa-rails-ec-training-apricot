module SessionsHelper
  def login(user)
    session[:user_id] = user.id
    current_cart
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_cart
    @current_cart ||= Cart.find_or_create_by!(user_id: current_user.id)
  end

  def logged_in?
    current_user.present?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    @current_cart = nil
  end
end
