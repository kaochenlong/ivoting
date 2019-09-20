class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :add_to_cart, :edit, :update]

  def index
    @products = Product.all
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: '商品更新完成'
    else
      render :edit
    end
  end

  def add_to_cart
    current_cart.add_item(@product.id)
    session[:cart9527] = current_cart.serialize

    redirect_to products_path, notice: '已加入購物車'
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :price,
      :description,
      :is_available,
      skus_attributes: [:id, :spec, :quantity, :_destroy]
    )
  end
end
