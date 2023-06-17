class CartItemsController < ApplicationController
  include SessionsHelper
  def add_cart
    cart = Cart.find_or_create_by!(user_id: current_user.id)
    @cart_item = cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    @cart_item.quantity += params[:quantity].to_i
    if @cart_item.save
      flash[:success] = t("notice.success_add_cart")
      redirect_to cart_path
    else
      flash[:danger] = t("notice.failure_add_cart")
      redirect_to product_path(params[:product_id])
    end
  end

  def update_quantity
    @cart_item = CartItem.find_by(id: params[:cart_item_id])
    if @cart_item.blank?
      flash[:danger] = t("notice.failure_update_quantity")
    else
      @cart_item.assign_attributes(cart_item_params)
      if @cart_item.save
        flash[:success] = t("notice.success_update_quantity")
      else
        flash[:danger] = t("notice.failure_update_quantity")
      end
    end
    redirect_to cart_path
  end

  def destroy
    CartItem.find_by(id: params[:id]).destroy!
    flash[:danger] = t("notice.success_destroy")
    redirect_to cart_path
  end

  private

    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
end
