class Product < ApplicationRecord
  extend FriendlyId
  extend SearchKeyword::QuerySearch
  friendly_id :title, use: :slugged
  monetize :price_cents

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :product_attributes, dependent: :destroy, inverse_of: :product
  # has_many :attribute_product_titles, through: :product_attributes
  has_many :product_vouchers, dependent: :destroy
  has_many :vouchers, through: :product_vouchers, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  belongs_to :brand

  has_many_attached :images

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :meta_title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { less_than: 500_000_000, greater_than: :discount }, unless: -> { price? }
  validates :quantity, numericality: { greater_than_or_equal_to: 0, less_than: 500 }, if: -> { quantity? }
  validates :content, presence: true, length: { minimum: 6, maximum: 10_000_000_000 }
  validates :brand_id, presence: true
  validates :images, content_type: %i[png jpg jpeg gif], attached: true

  scope :with_attached_images, -> { includes(images_attachments: :blob) }

  def display_image
    images[0].variant resize_to_limit: [720, 1280]
  end

  private

  def price?
    price.fractional == 0
  end

  def quantity?
    quantity.present?
  end
end
