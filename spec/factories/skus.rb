FactoryBot.define do
  factory :sku do
    product { nil }
    quantity { 1 }
    spec { "MyString" }
  end
end
