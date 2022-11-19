FactoryBot.define do
  factory :brand do
    title { Faker::Name.first_name }
    slug { Faker::Name.first_name }
  end
end
