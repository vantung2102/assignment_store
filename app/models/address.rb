class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :fullname, presence: true, length: { minimum: 6, maximum: 30 }
  validates :phone_number, phone_number: true, presence: true
  validates :province, presence: true
  validates :district, presence: true
  validates :addressDetail, presence: true
  validates :province_id, presence: true
  validates :district_id, presence: true
end
