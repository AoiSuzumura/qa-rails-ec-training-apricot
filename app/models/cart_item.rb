class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def subtotals
    product.price * quantity
  end
end
