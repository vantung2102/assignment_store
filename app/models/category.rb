class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :parent_category, class_name: 'Category', optional: true, foreign_key: :category_id
  has_many :child_category, class_name: 'Category', dependent: :destroy
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :title, presence: true, length: { minimum:3, maximum: 30 }
  validates :meta_title, presence: true, length: { minimum:3, maximum: 30 }
  validates :content, presence: true, length: { minimum:6, maximum: 500 }
end
