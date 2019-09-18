class OrderMailer < ApplicationMailer
  def confirm_email
    @order = params[:order]
    mail(to: @order.email , subject: "iVoting 訂單[#{@order.slug.upcase}]已付款")
  end
end
