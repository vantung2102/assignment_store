class User::ProductsCategoryService < ApplicationService
  def initialize(slug)
    @slug = slug
  end

  def call
    category = Category.friendly.find_by(slug: slug)
    
    child_category = category.child_category
    @products = []

    if child_category.present?
      child_category.each do |item|
        @products.concat(item.products)
      end
    else
      @products = category.products.limit(6)
    end
    
    @products
  end

  private

  attr_accessor :slug
end