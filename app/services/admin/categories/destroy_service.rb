class Admin::Categories::DestroyService < ApplicationService
  def initialize(category)
    @category = category
  end

  def call
    category&.destroy ? [true, 'Category was successfully destroy.'] : [false, 'Category was failure destroy.']
  end

  private

  attr_accessor :category
end
