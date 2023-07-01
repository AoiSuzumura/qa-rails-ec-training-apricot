class GuestSessionsController < ApplicationController
  include SessionsHelper
  def guest_login
    user = User.guest
    flash[:success] = t("notice.success_guest_login")
    login(user)
    redirect_to user_path(user)
  end
end
