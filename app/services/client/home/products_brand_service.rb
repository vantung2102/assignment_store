class Client::Home::ProductsBrandService < ApplicationService
  def initialize(slug)
    @slug = slug
  end

  def call
    brand = Brand.friendly.find_by(slug: slug)
    products = brand.with_attached_images.products.limit(6)
  end

  private

  attr_accessor :slug
end