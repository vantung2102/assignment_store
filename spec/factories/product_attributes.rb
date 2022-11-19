FactoryBot.define do
  factory :product_attribute do
    product_id { nil }
    name { Faker::Name.name }
  end
end
