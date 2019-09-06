require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context "基本功能" do
    it "每個 Cart Item 都可以計算它自己的金額（小計）。" do
      cart = Cart.new

      p1 = Product.create(name: 'aa', price: 100)
      p2 = Product.create(name: 'bb', price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.items.first.total_price).to be 300
      expect(cart.items.last.total_price).to be 100
    end
  end
end
