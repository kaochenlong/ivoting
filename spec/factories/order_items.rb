FactoryBot.define do
  factory :order_item do
    product { nil }
    quantity { 1 }
    order { nil }
  end
end
