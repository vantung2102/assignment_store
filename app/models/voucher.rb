class Voucher < ApplicationRecord
  enum status: { expired: false, applying: true }
  enum type_voucher: { normal: 0, special: 1 }

  has_many :user_vouchers, dependent: :destroy 
  has_many :users, through: :user_vouchers, dependent: :destroy
  has_many :product_vouchers, dependent: :destroy
  has_many :products, through: :product_vouchers, dependent: :destroy
end
