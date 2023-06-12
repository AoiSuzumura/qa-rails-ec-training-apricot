class CartsController < ApplicationController
  include SessionsHelper
  def show
    cart = current_user.cart
    @cart_items = cart.cart_items
    @sum = 0
  end
end
