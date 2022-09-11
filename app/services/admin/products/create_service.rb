class Admin::Products::CreateService < ApplicationService
  def initialize(product_params)
      @product_params = product_params
  end

  def call
    @product = Product.new(product_params)
    create = @product.save
    message = create ? "Product was successfully created." : "Product was failure created."
    [create, @product, message]  
  end

  private

  attr_accessor :product_params
end