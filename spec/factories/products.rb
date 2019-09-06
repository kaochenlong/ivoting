FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { 1 }
    description { "MyText" }
    is_available { false }
  end
end
