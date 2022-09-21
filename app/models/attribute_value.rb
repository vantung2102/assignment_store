class AttributeValue < ApplicationRecord
  belongs_to :product_attribute

  validates :price_attribute_product, presence: true, allow_blank: false
  validates :value, presence: true, allow_blank: false
end
