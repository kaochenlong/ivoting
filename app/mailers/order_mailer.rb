class OrderMailer < ApplicationMailer
  def confirm_email
    @order = params[:order]
    # mail(to: @order.user.email , subject: "訂單[#{@order.slug.upcase}]已付款")
    mail(to: @order.email , subject: "訂單[#{@order.slug.upcase}]已付款")
  end
end
