class CartItemsController < ApplicationController
  include SessionsHelper
  def add_cart
    @cart_item = current_cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    @cart_item.quantity += params[:quantity].to_i
    if @cart_item.save
      flash[:success] = t("notice.success_add_cart")
      redirect_to user_cart_path(current_user.id)
    else
      flash[:danger] = t("notice.failure_add_cart")
      redirect_to product_path(params[:product_id])
    end
  end

  def destroy
    CartItem.find_by(id: params[:id]).destroy!
    redirect_to user_cart_path
  end
end
