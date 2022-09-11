class Admin::Products::UpdateService < ApplicationService
  def initialize(product, product_params)
      @product = product
      @product_params = product_params
  end

  def call
    update = product.update(product_params)
    message = update ? "Product was successfully updated." : "Product was failure updated."
    [update, message]
  end

  private

  attr_accessor :product, :product_params
end