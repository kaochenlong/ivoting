class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_cart

  private
  def record_not_found
    render file: "#{Rails.root}/public/404.html",
           layout: false,
           status: :not_found
  end

  def current_cart
    @cart = @cart || Cart.from_hash(session[:cart9527])
  end
end
