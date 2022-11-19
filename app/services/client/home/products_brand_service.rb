class Client::Home::ProductsBrandService < ApplicationService
  def initialize(slug)
    @slug = slug
  end

  def call
    brand = Brand.friendly.find_by(slug: slug)
    products = brand.products.with_attached_images
  end

  private

  attr_accessor :slug
end
