class Product < ApplicationRecord
  belongs_to :category
  belongs_to :sale_status
  belongs_to :product_status
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :order_details, dependent: :destroy

  def self.search(search, category)
    products = all
    products = products.where("product_name LIKE ?", "%#{search}%") if search.present?
    products = products.where(category: category) if category.present?
    products
  end
end
