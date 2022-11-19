class Admin::Categories::CreateService < ApplicationService
  def initialize(category_params)
    @category_params = category_params
  end

  def call
    category = Category.new(category_params)
    create = category.save
    message = create ? 'Category was successfully created.' : 'Category was failure created.'
    [create, category, message]
  end

  private

  attr_accessor :category_params
end
