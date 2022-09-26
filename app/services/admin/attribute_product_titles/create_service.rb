class Admin::AttributeProductTitles::CreateService < ApplicationService
  def initialize(attribute_params)
      @attribute_params = attribute_params
  end

  def call
    attribute = AttributeProductTitle.new(attribute_params)
    create = attribute.save
    message = create ? "Attribute was successfully created." : "Attribute was failure created."
    
    [create, attribute, message]  
  end

  private

  attr_accessor :attribute_params
end
