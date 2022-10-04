class Address < ApplicationRecord
  belongs_to :user

  validates :fullname, presence: true, length: { minimum:6, maximum: 30 }
  validates :phone_number, phone_number: true, presence: true
  validates :province_id, presence: true
  validates :district_id, presence: true
  validates :ward_id, presence: true
  validates :addressDetail, presence: true
end
