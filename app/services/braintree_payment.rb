class BraintreePayment

  # keyword arguments
  def initialize(order: nil, nonce: '')
    @order = order
    @nonce = nonce
  end

  def generate_token
    gateway.client_token.generate
  end

  def run
    gateway.transaction.sale(
      amount: @order.total_price,
      payment_method_nonce: @nonce,
      options: {
        submit_for_settlement: true
      }
    )
  end

  private
  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["braintree_merchant_id"],
      public_key: ENV["braintree_public_key"],
      private_key: ENV["braintree_private_key"]
    )
  end
end