require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }

  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
      # expect(cart.empty?).to be true
      # expect(cart.empty?).to be_truthy
      expect(cart).to be_empty

      cart.add_item(1)
      expect(cart.empty?).to be false
      expect(cart.present?).to be true
    end

    it "加相同種類的商品，購買項目（CartItem）不會增加，但商品的數量會改變。" do
      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }
      2.times { cart.add_item(1) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
      p1 = create(:product)
      p2 = create(:product)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.items.first.product).to be_a Product
      expect(cart.items.first.product_id).to be p1.id
    end

    it "可以計算整台購物車的總消費金額。" do
      p1 = create(:product, price: 100)
      p2 = create(:product, price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to be 400
    end

    it "特別日期全面打 9 折" do
      # 2/10 打 9 折
      t = Time.local(2008, 2, 10, 10, 5, 0)
      Timecop.travel(t)

      p1 = create(:product, price: 100)
      p2 = create(:product, price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to eq 360
    end
  end

  context "進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡。" do
      p1 = create(:product)
      p2 = create(:product)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.serialize).to eq cart_hash
    end

    it "也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容。" do
      cart = Cart.from_hash(cart_hash)

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3
    end
  end

  private
  def cart_hash
    {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 2}
      ]
    }
  end
end

#
#