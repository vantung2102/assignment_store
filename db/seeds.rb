# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
# 50.times do
#   user = User.new(
#     email: Faker::Internet.email, 
#     name: Faker::Name.name,
#     phone: '0984235062',
#     gender: 'female',
#     encrypted_password: '$2a$12$7I4yZDN6QaltncwDLn/hC.febny2EXe6k.l/6eO1aeOuyOou6uHAK', 
#     password: 'Levantung123$', 
#     password_confirmation: 'Levantung123$', 
#     reset_password_token: nil, 
#     reset_password_sent_at: nil, 
#     remember_created_at: nil,
#   )
#   user.skip_confirmation!
#   user.save
# end


# Product no attribute
2.times do
  # men
  men_name = 'Men ' + Faker::Commerce.product_name
  men = Product.new(
    title: men_name, 
    meta_title: men_name,
    content: Faker::Lorem.paragraphs,
    slug: men_name,
    price: Faker::Commerce.price(range: 20..200.0), 
    discount: Faker::Commerce.price(range: 0..10.0), 
    quantity: rand(50..200),
    brand_id: rand(1..8),
  )
  image_1 = rand(1..5)
  image_2 = rand(6..8)
  image_3 = rand(9..10)
  
  men.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_1}.jpg"), filename: "men_#{image_1}.jpg"])
  men.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_2}.jpg"), filename: "men_#{image_2}.jpg"])
  men.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_3}.jpg"), filename: "men_#{image_3}.jpg"])

  men.save
  men.product_categories.build(category_id: rand(4..8)).save

  # girl
  girl_name = 'Girl ' + Faker::Commerce.product_name
  girl = Product.new(
    title: girl_name, 
    meta_title: girl_name,
    content: Faker::Lorem.paragraphs,
    slug: girl_name,
    price: Faker::Commerce.price(range: 20..200.0), 
    discount: Faker::Commerce.price(range: 0..10.0), 
    quantity: rand(50..200),
    brand_id: rand(1..8),
  )
  
  girl.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_1}.jpg"), filename: "girl_#{image_1}.jpg"])
  girl.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_2}.jpg"), filename: "girl_#{image_2}.jpg"])
  girl.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_3}.jpg"), filename: "girl_#{image_3}.jpg"])

  girl.save
  girl.product_categories.build(category_id: rand(4..8)).save

  # shoes
  shoes_name = 'Shoes ' + Faker::Commerce.product_name
  shoes = Product.new(
    title: shoes_name, 
    meta_title: shoes_name,
    content: Faker::Lorem.paragraphs,
    slug: shoes_name,
    price: Faker::Commerce.price(range: 20..200.0), 
    discount: Faker::Commerce.price(range: 0..10.0), 
    quantity: rand(50..200),
    brand_id: rand(1..8),
  )
  
  shoes.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_1}.jpg"), filename: "shoes_#{image_1}.jpg"])
  shoes.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_2}.jpg"), filename: "shoes_#{image_2}.jpg"])
  shoes.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_3}.jpg"), filename: "shoes_#{image_3}.jpg"])

  shoes.save
  shoes.product_categories.build(category_id: rand(1..3)).save
end

# 1 attribute

3.times do
  # men
  men_name = 'Men ' + Faker::Commerce.product_name
  men = Product.new(
    title: men_name, 
    meta_title: men_name,
    content: Faker::Lorem.paragraphs,
    slug: men_name,
    price: Faker::Commerce.price(range: 20..200.0), 
    discount: Faker::Commerce.price(range: 0..10.0), 
    brand_id: rand(1..8),
  )
  image_1 = rand(1..5)
  image_2 = rand(6..8)
  image_3 = rand(9..10)

  men.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_1}.jpg"), filename: "men_#{image_1}.jpg"])
  attribute = men.product_attributes.build(name: 'color')

  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_1}.jpg"), filename: "men_#{image_1}.jpg"])
  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_2}.jpg"), filename: "men_#{image_2}.jpg"])
  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_3}.jpg"), filename: "men_#{image_3}.jpg"])

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.save
  men.save
  men.product_categories.build(category_id: rand(4..8)).save

  # girl
  girl_name = 'Girl ' + Faker::Commerce.product_name
  girl = Product.new(
    title: girl_name, 
    meta_title: girl_name,
    content: Faker::Lorem.paragraphs,
    slug: girl_name,
    price: Faker::Commerce.price(range: 20..200.0), 
    discount: Faker::Commerce.price(range: 0..10.0), 
    brand_id: rand(1..8),
  )

  girl.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_1}.jpg"), filename: "girl_#{image_1}.jpg"])
  attribute = girl.product_attributes.build(name: 'color')

  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_1}.jpg"), filename: "girl_#{image_1}.jpg"])
  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_2}.jpg"), filename: "girl_#{image_2}.jpg"])
  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_3}.jpg"), filename: "girl_#{image_3}.jpg"])

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.save
  girl.save
  girl.product_categories.build(category_id: rand(4..8)).save

  # shoes
  shoes_name = 'Men ' + Faker::Commerce.product_name
  shoes = Product.new(
    title: shoes_name, 
    meta_title: shoes_name,
    content: Faker::Lorem.paragraphs,
    slug: shoes_name,
    price: Faker::Commerce.price(range: 20..200.0), 
    discount: Faker::Commerce.price(range: 0..10.0), 
    brand_id: rand(1..8),
  )

  shoes.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_1}.jpg"), filename: "shoes_#{image_1}.jpg"])
  attribute = shoes.product_attributes.build(name: 'color')

  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_1}.jpg"), filename: "shoes_#{image_1}.jpg"])
  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_2}.jpg"), filename: "shoes_#{image_2}.jpg"])
  attribute.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_3}.jpg"), filename: "shoes_#{image_3}.jpg"])

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.attribute_values.build(
    attribute_1: Faker::Commerce.color, 
    price_attribute_product: Faker::Commerce.price(range: 20..200.0),
    stock: rand(50..200)
  ).save

  attribute.save
  shoes.save
  shoes.product_categories.build(category_id: rand(4..8)).save
end

# 2 attribute
10.times do
  # men
  men_name = 'Men ' + Faker::Commerce.product_name
  men = Product.new(
    title: men_name, 
    meta_title: men_name,
    content: Faker::Lorem.paragraphs,
    slug: men_name,
    discount: Faker::Commerce.price(range: 0..10.0), 
    brand_id: rand(1..8),
  )
  image_1 = rand(1..5)
  image_2 = rand(6..8)
  image_3 = rand(9..10)

  men.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_1}.jpg"), filename: "men_#{image_1}.jpg"])
  attribute1 = men.product_attributes.build(name: 'color')
  attribute2 = men.product_attributes.build(name: 'size')

  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_1}.jpg"), filename: "men_#{image_1}.jpg"])
  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_2}.jpg"), filename: "men_#{image_2}.jpg"])
  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/men/men_#{image_3}.jpg"), filename: "men_#{image_3}.jpg"])

  attribute1.save
  attribute2.save
  men.save
  men.product_categories.build(category_id: rand(4..8)).save
  
  color = [Faker::Commerce.color, Faker::Commerce.color, Faker::Commerce.color]
  size = [ 'S', 'M', 'L', 'XL' ]

  color.each do |item|
    size.each do |item_2|
      product_attribute_value_1 = attribute1.product_attribute_values.build
      product_attribute_value_2 = attribute2.product_attribute_values.build

      attribute_value = AttributeValue.new(
        attribute_1: item,
        attribute_2: item_2,
        price_attribute_product: Faker::Commerce.price(range: 20..200.0),
        stock: rand(50..200)
      )

      attribute_value.save

      product_attribute_value_1.attribute_value_id = attribute_value.id
      product_attribute_value_2.attribute_value_id = attribute_value.id

      product_attribute_value_1.save
      product_attribute_value_2.save
    end
  end
  
  

  # girl
  girl_name = 'Girl ' + Faker::Commerce.product_name
  girl = Product.new(
    title: girl_name, 
    meta_title: girl_name,
    content: Faker::Lorem.paragraphs,
    slug: girl_name,
    discount: Faker::Commerce.price(range: 0..10.0), 
    brand_id: rand(1..8),
  )

  girl.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_1}.jpg"), filename: "girl_#{image_1}.jpg"])
  attribute1 = girl.product_attributes.build(name: 'color')
  attribute2 = girl.product_attributes.build(name: 'size')

  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_1}.jpg"), filename: "girl_#{image_1}.jpg"])
  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_2}.jpg"), filename: "girl_#{image_2}.jpg"])
  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/girl/girl_#{image_3}.jpg"), filename: "girl_#{image_3}.jpg"])

  attribute1.save
  attribute2.save
  girl.save
  girl.product_categories.build(category_id: rand(4..8)).save
  
  color = [Faker::Commerce.color, Faker::Commerce.color, Faker::Commerce.color]
  size = [ 'S', 'M', 'L', 'XL' ]

  color.each do |item|
    size.each do |item_2|
      product_attribute_value_1 = attribute1.product_attribute_values.build
      product_attribute_value_2 = attribute2.product_attribute_values.build

      attribute_value = AttributeValue.new(
        attribute_1: item,
        attribute_2: item_2,
        price_attribute_product: Faker::Commerce.price(range: 20..200.0),
        stock: rand(50..200)
      )

      attribute_value.save

      product_attribute_value_1.attribute_value_id = attribute_value.id
      product_attribute_value_2.attribute_value_id = attribute_value.id

      product_attribute_value_1.save
      product_attribute_value_2.save
    end
  end

  # shoes
  shoes_name = 'Shoes ' + Faker::Commerce.product_name
  shoes = Product.new(
    title: shoes_name, 
    meta_title: shoes_name,
    content: Faker::Lorem.paragraphs,
    slug: shoes_name,
    discount: Faker::Commerce.price(range: 0..10.0), 
    brand_id: rand(1..8),
  )

  shoes.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_1}.jpg"), filename: "shoes_#{image_1}.jpg"])
  attribute1 = shoes.product_attributes.build(name: 'color')
  attribute2 = shoes.product_attributes.build(name: 'size')

  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_1}.jpg"), filename: "shoes_#{image_1}.jpg"])
  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_2}.jpg"), filename: "shoes_#{image_2}.jpg"])
  attribute1.images.attach([io: File.open(Rails.root + "app/assets/images/home/products/shoes/shoes_#{image_3}.jpg"), filename: "shoes_#{image_3}.jpg"])

  attribute1.save
  attribute2.save
  shoes.save
  shoes.product_categories.build(category_id: rand(4..8)).save
  
  color = [Faker::Commerce.color, Faker::Commerce.color, Faker::Commerce.color].uniq
  size = [ '38', '39', '40', '41' ]

  color.each do |item|
    size.each do |item_2|
      product_attribute_value_1 = attribute1.product_attribute_values.build
      product_attribute_value_2 = attribute2.product_attribute_values.build

      attribute_value = AttributeValue.new(
        attribute_1: item,
        attribute_2: item_2,
        price_attribute_product: Faker::Commerce.price(range: 20..200.0),
        stock: rand(50..200)
      )

      attribute_value.save

      product_attribute_value_1.attribute_value_id = attribute_value.id
      product_attribute_value_2.attribute_value_id = attribute_value.id

      product_attribute_value_1.save
      product_attribute_value_2.save
    end
  end
end
