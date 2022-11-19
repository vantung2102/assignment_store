class ProductAttributeValue < ApplicationRecord
  belongs_to :product_attribute
  belongs_to :attribute_value
end
