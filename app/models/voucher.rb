class Voucher < ApplicationRecord
  enum status: { expired: false, applying: true }
  enum type_voucher: { normal: 0, special: 1 }

  has_many :user_vouchers, dependent: :destroy
  has_many :users, through: :user_vouchers, dependent: :destroy
  has_many :product_vouchers, dependent: :destroy
  has_many :products, through: :product_vouchers, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :description, presence: true
  validates :max_user, presence: true, numericality: { greater_than: 0 }
  validates :type_voucher, presence: true
  validates :discount_mount, presence: true, numericality: { greater_than: 0 }
  validates :apply_amount, presence: true, numericality: { lest_than_or_equal_to: :discount_mount }
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_datetime :end_time, after: :start_time
end
