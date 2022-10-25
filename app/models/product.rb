class Product < ApplicationRecord
  extend FriendlyId
  extend SearchKeyword::QuerySearch
  # searchkick
  friendly_id :title, use: :slugged
  monetize :price_cents

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :product_attributes, dependent: :destroy, inverse_of: :product
  has_many :attribute_product_titles, through: :product_attributes
  has_many :product_vouchers, dependent: :destroy
  has_many :vouchers, through: :product_vouchers, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  # accepts_nested_attributes_for :product_attributes, reject_if: :all_blank, allow_destroy: true

  belongs_to :brand#, counter_cache: true

  has_many_attached :images

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :meta_title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { less_than: 500000000, greater_than: :discount }, unless: -> { price? }
  validates :quantity, numericality: { greater_than: 0, less_than: 500 }, if: -> { quantity? }
  validates :content, presence: true, length: { minimum: 6, maximum: 10000000000 } 
  validates :brand_id, presence: true
  # validates :categories, presence: true
  validates :images, content_type: [:png, :jpg, :jpeg, :gif], attached: true

  scope :with_attached_images, -> { includes(images_attachments: :blob) }

  def display_image
    images[0].variant resize_to_limit: [300, 200]
  end

  private

  def price?
    price.fractional == 0
  end

  def quantity?
    quantity.present?
  end
  
end
