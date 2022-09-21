class ProductAttribute < ApplicationRecord
  has_many :attribute_values, dependent: :destroy, dependent: :destroy, inverse_of: :product_attribute
  accepts_nested_attributes_for :attribute_values, reject_if: :all_blank, allow_destroy: true

  belongs_to :attribute_product_title
  belongs_to :product

  validates :product_attribute, presence: false
end
