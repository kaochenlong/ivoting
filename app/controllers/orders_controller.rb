class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      @order.order_items << OrderItem.new(product: item.product, quantity: item.quantity)
    end

    if @order.save
      session[:cart9527] = nil
      redirect_to payment_order_path(@order), notice: '訂單已成立'
    else
      render 'carts/checkout'
    end
  end

  def payment
  end

  private

  def order_params
    params.require(:order).permit(:recipient, :phone, :address, :note)
  end
end