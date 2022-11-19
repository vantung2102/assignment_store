FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    phone { '0984235062' }
    gender { 'men' }
    email { 'vantung21022@gmail.com' }
    password { 'Levantung123@' }
    password_confirmation { 'Levantung123@' }
  end
end
