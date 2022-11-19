FactoryBot.define do
  factory :voucher do
    code { Faker::Code.nric }
    name { Faker::Name.name_with_middle }
    max_user { rand(100..200) }
    type_voucher { Voucher.type_vouchers[:normal] }
    discount_mount { rand(100..200) }
    status { true }
    start_time { Faker::Date.in_date_period(month: 10) }
    end_time { Faker::Date.in_date_period(month: 11)  }
    cost { rand(100..200) }
    apply_amount { 0 }
    description { Faker::Lorem.paragraph }
  end
end
