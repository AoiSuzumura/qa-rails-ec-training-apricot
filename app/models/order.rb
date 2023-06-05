class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  def order_preparing? 
    order_details.any? do |order_detail|
      order_detail.shipment_status_id == 1
    end
  end
  

  def total_price
    order_details.sum(&:subtotals)
  end
end