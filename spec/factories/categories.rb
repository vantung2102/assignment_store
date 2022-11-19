FactoryBot.define do
  factory :category do
    title { Faker::Name.first_name }
    meta_title { Faker::Name.first_name }
    slug { Faker::Name.first_name }
    content { Faker::Lorem.paragraph }
  end
end
