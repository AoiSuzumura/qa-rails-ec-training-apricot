class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_order, only: [:show]
  def index
    @orders = current_user.orders.all.page(params[:page])
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def correct_order
    order = Order.find_by(id: params[:id])
    return if order.nil?
    if current_user != order.user
      flash[:danger] = "他人の情報にアクセスすることはできません"
      redirect_to root_path
    end
  end
  def destroy
    Order.find_by(id: params[:id]).destroy!
    redirect_to order_path
  end
end