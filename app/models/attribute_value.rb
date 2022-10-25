class AttributeValue < ApplicationRecord
  has_many :product_attribute_values, dependent: :destroy
  has_many :product_attributes, through: :product_attribute_values, dependent: :destroy
  has_many :attribute_values, dependent: :destroy

  validates :price_attribute_product, presence: true, allow_blank: false
  validates :stock, presence: true, allow_blank: false
end
