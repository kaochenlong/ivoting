require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }

  # def cart
  #   Cart.new
  # end

  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
      expect(cart.empty?).to be true
      # expect(cart.empty?).to be_truthy
      # expect(cart).to be_empty

      cart.add_item(1)
      expect(cart.empty?).to be false
    end

    it "加相同種類的商品，購買項目（CartItem）不會增加，但商品的數量會改變。" do
      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }
      2.times { cart.add_item(1) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
      p1 = Product.create(name: 'aa', price: 100)
      p2 = Product.create(name: 'bb', price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.items.first.product).to be_a Product
      expect(cart.items.first.product_id).to be p1.id
    end

    it "可以計算整台購物車的總消費金額。" do
      p1 = Product.create(name: 'aa', price: 100)
      p2 = Product.create(name: 'bb', price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to be 400
    end

    it "特別日期全面打 9 折" do
      # 2/10 打 9 折
      t = Time.local(2008, 2, 10, 10, 5, 0)
      Timecop.travel(t)

      p1 = Product.create(name: 'aa', price: 100)
      p2 = Product.create(name: 'bb', price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to eq 360
    end
  end

  context "進階功能" do
  end
end
