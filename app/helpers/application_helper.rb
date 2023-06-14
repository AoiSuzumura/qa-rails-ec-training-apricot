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
    cart_item.product.price * cart_item.quantity
  end
end
