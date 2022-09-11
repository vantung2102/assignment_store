class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories, dependent: :destroy

  has_many_attached :images

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :meta_title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 500000000 }
  validates :discount, presence: true, numericality: { greater_than: 0, less_than: :price }
  validates :quantity, presence: true, numericality: { greater_than: 0, less_than: 500 }
  validates :content, presence: true, length: { minimum: 6, maximum: 1000 } 
  validates :images, content_type: [:png, :jpg, :jpeg, :gif], attached: true

  def display_image
    image.variant resize_to_limit: [300, 200]
  end
end
