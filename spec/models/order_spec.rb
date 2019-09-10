require 'rails_helper'

RSpec.describe Order, type: :model do
  it "訂單需要有使用者" do
    #
  end

  describe "驗證收件人相關資料" do
    context "有效資料" do
      it "填寫完整資料" do
        order = build(:order)
        expect(order).to be_valid
      end
    end

    context "無效資料" do
      it "未填寫完整資料" do
        order = build(:order, :invalid)
        expect(order).not_to be_valid
      end
    end
  end

end
