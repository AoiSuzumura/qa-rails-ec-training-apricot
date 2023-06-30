class ApplicationController < ActionController::Base
  include SessionsHelper

  def current_user
    super || User.guest
  end
end
