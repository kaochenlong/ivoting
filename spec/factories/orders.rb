FactoryBot.define do
  factory :order do
    recipient { Faker::Name.name }
    note { Faker::Lorem.sentences }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
    status { "pending" }

    trait :invalid do
      phone { nil }
      address { nil }
    end
  end
end
