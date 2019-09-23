class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:show, :payment, :transaction]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
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
    @token = BraintreePayment.new.generate_token
  end

  def transaction
    if @order.may_pay?

      result = BraintreePayment.new(order: @order, nonce: params[:payment_method_nonce]).run

      if result.success?
        @order.pay!
        # 寄 email
        PostmanJob.set(wait: 10.seconds).perform_later(@order)

        redirect_to orders_path, notice: '刷卡已完成'
      else
        redirect_to orders_path, notice: '付款出現錯誤'
      end
    else
      redirect_to orders_path, notice: '訂單已完成付款'
    end
  end

  private
  def find_order
    @order = current_user.orders.friendly.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:recipient, :phone, :address, :note)
  end
end