class CartsController < ApplicationController
  def show
  end

  def destroy
    session[:cart9527] = nil
    redirect_to products_path, notice: '購物車已清空'
  end

  def checkout
  end
end