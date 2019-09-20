FactoryBot.define do
  factory :signature do
    candidate { nil }
    content { "MyString" }
    active { false }
  end
end
