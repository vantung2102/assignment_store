class Admin::Products::UpdateService < ApplicationService
  def initialize(product, product_params)
      @product = product
      @product_params = product_params
  end

  def call
    if product_params[:product_attributes_attributes].nil?
      update = product.update(product_params.except(:product_attributes_attributes))
    else
      update = product.update(product_params)
    end

    update
  end

  private

  attr_accessor :product, :product_params
end