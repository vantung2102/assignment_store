class Admin::Products::DestroyService < ApplicationService
  def initialize(product)
    @product = product
  end

  def call
    product&.destroy ? [true, 'Product was successfully destroy.'] : [false, 'product was failure destroy.']
  end

  private

  attr_accessor :product
end
