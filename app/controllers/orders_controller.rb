class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:show, :payment, :transaction]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    OrderMailer.with(order: @order).confirm_email.deliver_later
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
    @token = braintree_gateway.client_token.generate
  end

  def transaction
    if @order.may_pay?
      result = braintree_gateway.transaction.sale(
        amount: @order.total_price,
        payment_method_nonce: params[:payment_method_nonce],
        options: {
          submit_for_settlement: true
        }
      )

      if result.success?
        @order.pay!
        # 寄 email

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

  def braintree_gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["braintree_merchant_id"],
      public_key: ENV["braintree_public_key"],
      private_key: ENV["braintree_private_key"]
    )
  end
end