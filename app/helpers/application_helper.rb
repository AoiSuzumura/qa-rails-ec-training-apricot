module ApplicationHelper
  def full_title(title = "")
    default_title = "Myapp"
    if title.blank?
      default_title
    else
      title.to_s
    end
  end

  def cart_total_price(cart_item)
    cart_item_total_price = cart_item.product.price * cart_item.quantity
    @sum += cart_item_total_price
    return cart_item_total_price
  end
end
