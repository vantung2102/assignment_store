class Client::Home::ProductsCategoryService < ApplicationService
  def initialize(slug)
    @slug = slug
  end

  def call
    category = Category.friendly.find_by(slug: slug)
    child_category = category.child_category

    products = []
    if child_category.present?
      child_category.each do |item|
        products.concat(item.products.with_attached_images)
      end
    else
      products = category.products.with_attached_images
    end

    products
  end

  private

  attr_accessor :slug
end
