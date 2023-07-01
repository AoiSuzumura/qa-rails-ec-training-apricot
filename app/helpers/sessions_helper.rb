module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    current_user.present?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil # rubocop:disable Rails/HelperInstanceVariable
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t("notice.require_rogin")
      redirect_to login_path
    end
  end
end
