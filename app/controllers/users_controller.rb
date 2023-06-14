class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  include SessionsHelper

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      user_classification = UserClassification.find_by(user_classification_name: "一般ユーザー")
      @user = user_classification.users.create!(user_params)
      Cart.create!(user_id: @user.id)
    end
    flash[:success] = t("notice.success_signup")
    redirect_to login_path
  rescue
    flash.now[:danger] = t("notice.failure_signup")
    render "new"
  end

  def update
    @user.assign_attributes(user_params)
    if @user.save
      flash[:success] = t("notice.success_update")
      redirect_to @user
    else
      flash.now[:danger] = t("notice.failure_update")
      render "edit"
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy!
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:last_name,
                                   :first_name,
                                   :zipcode,
                                   :prefecture,
                                   :municipality,
                                   :address,
                                   :apartments,
                                   :email,
                                   :phone_number,
                                   :password,
                                   :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = t("notice.require_rogin")
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find_by(id: params[:id])
      if current_user != @user
        flash[:danger] = t("notice.cannot_access")
        redirect_to root_path
      end
    end
end
