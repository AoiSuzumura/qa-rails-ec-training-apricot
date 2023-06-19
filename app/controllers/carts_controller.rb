class CartsController < ApplicationController
  include SessionsHelper
  def show
    @cart = Cart.find_or_create_by!(user_id: current_user.id)
    @cart_items = @cart.cart_items
  end
end
