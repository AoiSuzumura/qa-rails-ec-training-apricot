class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  include SessionsHelper

  def new
    @user = User.new
  end

  def create
    user_classification = UserClassification.find_by(user_classification_name: "一般ユーザー")
    @user = user_classification.users.build(user_params)
    if @user.save
      flash[:success] = "ユーザーを登録しました。こちらからログインしてください。"
      redirect_to login_path
    else
      flash.now[:danger] = "登録に失敗しました。"
      render "new"
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    if @user.save
      flash[:success] = "更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    # TODO: redirect_to login_path は、後で root_path に修正
    # redirect_to root_path 
    redirect_to login_path
  end
  private
  
  def user_params
    params.require(:user).permit(:last_name, :first_name, :zipcode, :prefecture, :municipality, :address, :apartments, :email, :phone_number, :password, :password_confirmation)
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    if current_user != @user
      flash[:danger] = "他人の情報にアクセスすることはできません"
      # TODO: redirect_to login_path は、後で root_path に修正
      # redirect_to root_path
      redirect_to login_path
    end
  end

end
