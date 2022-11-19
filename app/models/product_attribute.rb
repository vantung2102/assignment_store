class ProductAttribute < ApplicationRecord
  has_many :product_attribute_values, dependent: :destroy
  has_many :attribute_values, through: :product_attribute_values, dependent: :destroy

  belongs_to :product

  validates :name, presence: true

  has_many_attached :images

  def display_image
    images[0].variant resize_to_limit: [720, 1280]
  end
end
