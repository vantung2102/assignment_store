class Admin::Brands::UpdateService < ApplicationService
  def initialize(brand, brand_params)
    @brand = brand
    @brand_params = brand_params
  end

  def call
    update = brand.update(brand_params)
    message = update ? 'Brand was successfully updated.' : 'Brand was failure updated.'
    [update, message]
  end

  private

  attr_accessor :brand, :brand_params
end
