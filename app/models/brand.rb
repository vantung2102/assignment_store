class Brand < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :products

  validates :title, presence: true, length: { minimum: 2, maximum: 30}, uniqueness: true

  scope :include_products, -> { includes(:products) }
end
