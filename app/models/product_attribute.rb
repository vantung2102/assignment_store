class ProductAttribute < ApplicationRecord
  has_many :product_attribute_values, dependent: :destroy
  has_many :attribute_values, through: :product_attribute_values, dependent: :destroy

  # accepts_nested_attributes_for :attribute_values, reject_if: :all_blank, allow_destroy: true

  belongs_to :product

  validates :name, presence: true

  has_many_attached :images
end
