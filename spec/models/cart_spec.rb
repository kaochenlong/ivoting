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

    it "商品可以放到購物車裡，也可以再拿出來。" do
      cart = Cart.new

      p1 = Product.create(name: 'aa', price: 100)
      p2 = Product.create(name: 'bb', price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.items.first.product).to be_a Product
      expect(cart.items.first.product_id).to be p1.id
    end

    it "可以計算整台購物車的總消費金額。" do
      cart = Cart.new

      p1 = Product.create(name: 'aa', price: 100)
      p2 = Product.create(name: 'bb', price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to be 400
    end
  end

  context "進階功能" do
  end
end

# -
# -
# - 特別活動可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運費）。
