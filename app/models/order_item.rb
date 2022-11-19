class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :attribute_value, optional: true
end
