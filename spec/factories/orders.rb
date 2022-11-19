FactoryBot.define do
  factory :order do
    token { Faker::Code.nric  }
    status { Order.statuses[:success] }
    shipping { rand(1..10) }
    total { rand(100.. 200) }
    discount { rand(2..10) }
    content { Faker::Lorem.paragraph }
    user_id { nil }
    payment_gateway { Order.payment_gateways[:stripe] }
    address_id { nil }
  end
end
