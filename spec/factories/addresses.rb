FactoryBot.define do
  factory :address do
    fullname { 'le van tung' }
    phone_number { '0984235062' }
    addressDetail { '85/23c KDC Dai Hai' }
    user_id { nil }
    status { false }

    province { 'TP.Hồ Chí Minh' }
    province_id { 202 }

    district { 'Quận 10' }
    district_id { 1452 }

    ward { 'Phường 3' }
    ward_id { 21003 }
  end
end
