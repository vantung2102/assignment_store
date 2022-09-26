class AttributeProductTitle < ApplicationRecord
  has_many :product_attributes, dependent: :destroy
  has_many :products, through: :product_attributes, dependent: :destroy

  validates :title, presence: true
end
