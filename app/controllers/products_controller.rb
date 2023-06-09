class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page])
    @products = @products.where("product_name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @products = @products.where(category: params[:category]) if params[:category].present?
  end

  def show
    @product = Product.find_by(id: params[:id])
  end
end
