require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
      cart = Cart.new
      expect(cart.empty?).to be true

      cart.add_item(1)
      expect(cart.empty?).to be false
    end

    it "加相同種類的商品，購買項目（CartItem）不會增加，但商品的數量會改變。" do
      cart = Cart.new
      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }
      2.times { cart.add_item(1) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
    end
  end

  context "進階功能" do
  end
end

# -
# - 如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變。
# - 商品可以放到購物車裡，也可以再拿出來。
# - 每個 Cart Item 都可以計算它自己的金額（小計）。
# - 可以計算整台購物車的總消費金額。
# - 特別活動可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運費）。
