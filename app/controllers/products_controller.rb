class ProductsController < ApplicationController

  before_action :find_product, only: [:show, :add_to_cart]

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    cart = Cart.new
    cart.add_item(@product.id)

    redirect_to products_path, notice: '已加入購物車'
  end

  private

  def find_product
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :file => "#{Rails.root}/public/404.html",
             :layout => false,
             :status => :not_found
    end
  end
end
