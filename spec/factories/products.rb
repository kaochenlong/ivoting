FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { Faker::Number.between(from: 10, to: 200) }
    description { Faker::Lorem.sentences }
    is_available { false }
  end
end
