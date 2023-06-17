class ProductsController < ApplicationController
  def index
    @products = Product.search(params[:search], params[:category]).page(params[:page])
  end

  def show
    @product = Product.find_by(id: params[:id])
  end
end
