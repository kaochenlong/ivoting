class ProductsController < ApplicationController

  before_action :find_product, only: [:show, :add_to_cart]

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    cart = Cart.from_hash(session[:cart9527])
    cart.add_item(@product.id)

    session[:cart9527] = cart.serialize

    redirect_to products_path, notice: '已加入購物車'
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
