class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :parent_category, class_name: 'Category', optional: true, foreign_key: :category_id
  has_many :child_category, class_name: 'Category', dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories, dependent: :destroy

  validates :title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :meta_title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :content, presence: true, length: { minimum: 1, maximum: 500 }

  scope :show_categories, -> { where category_id: nil }
  scope :include_categories, -> { includes(:child_category) }
end
