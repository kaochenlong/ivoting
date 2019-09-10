class OrdersController < ApplicationController
  def create
    @order = current_user.orders.build(order_params)

    if @order.save
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