class Admin::Categories::UpdateService < ApplicationService
  def initialize(category, category_params)
    @category = category
    @category_params = category_params
  end

  def call
    update = category.update(category_params)
    message = update ? 'Category was successfully updated.' : 'Category was failure updated.'
    [update, message]
  end

  private

  attr_accessor :category, :category_params
end
