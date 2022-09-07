class Category < ApplicationRecord
  belongs_to :parent_category, class_name: 'Category', optional: true, foreign_key: :category_id
  has_many :child_category, class_name: 'Category', dependent: :destroy
  has_many :product_categories
  has_many :products, through: :product_categories

  before_create :make_slug

  private

  def make_slug
    self.slug = title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end
end
