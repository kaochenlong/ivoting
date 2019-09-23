class ApplicationController < ActionController::Base
  include CurrentCart
  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorize

  private
  def record_not_found
    render file: "#{Rails.root}/public/404.html",
           layout: false,
           status: :not_found
  end

  def not_authorize
    redirect_to root_path, notice: '權限不足'
  end
end
