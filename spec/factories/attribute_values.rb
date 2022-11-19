FactoryBot.define do
  factory :attribute_value do
    price_attribute_product { rand(10..0) }
    stock { rand(10..0) }
    attribute_1 { Faker::Name.unique.name }
    attribute_2 { nil }
  end
end
