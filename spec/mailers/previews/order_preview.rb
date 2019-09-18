class OrderPreview < ActionMailer::Preview
  def confirm_email
    order = FactoryBot.create(:order)

    OrderMailer.with(order: order).confirm_email
  end
end
