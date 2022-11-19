FactoryBot.define do
  title = Faker::Commerce.product_name
  factory :product do
    title { title }
    meta_title { title }
    content { Faker::Lorem.paragraph }
    discount { Faker::Commerce.price(range: 0..10.0) }
    price { Faker::Commerce.price(range: 20..200.0) }
    quantity { nil }
    brand_id { nil }
    images { [Rack::Test::UploadedFile.new('spec/fixtures/girl_5.jpg', 'images/jpg')] }
  end
end
