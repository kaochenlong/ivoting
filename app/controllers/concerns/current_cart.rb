module CurrentCart
  extend ActiveSupport::Concern

  included do
    helper_method :current_cart
  end

  module ClassMethods
  end

  private
  def current_cart
    @cart = @cart || Cart.from_hash(session[:cart9527])
  end
end