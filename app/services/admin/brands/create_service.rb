class Admin::Brands::CreateService < ApplicationService
  def initialize(brand_params)
    @brand_params = brand_params
  end

  def call
    brand = Brand.new(brand_params)
    create = brand.save
    message = create ? 'Brand was successfully created.' : 'Brand was failure created.'
    [create, brand, message]
  end

  private

  attr_accessor :brand_params
end
