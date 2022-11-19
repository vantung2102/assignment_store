class Admin::Brands::DestroyService < ApplicationService
  def initialize(brand)
    @brand = brand
  end

  def call
    brand&.destroy ? [true, 'Brand was successfully destroy.'] : [false, 'Brand was failure destroy.']
  end

  private

  attr_accessor :brand
end
