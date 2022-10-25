class Admin::Products::CreateService < ApplicationService
  def initialize(product_params)
      @product_params = product_params
  end

  def call
    product = Product.new(product_params.except(:product_attribute_1, :product_attribute_2))
    
    product_attribute_1 = product_params[:product_attribute_1]
    product_attribute_2 = product_params[:product_attribute_2]

    if product_attribute_1.nil? && product_attribute_2.nil?
      create = product.save
      return [create, product]
    else
      if product_attribute_1.present? && product_attribute_2.nil?
        title_attribute_1 = product_attribute_1[:name][0]
        ActiveRecord::Base.transaction do
          value_attribute_1 = product_attribute_1[:attribute_value]
          attribute1 = product.product_attributes.build(product_attribute_1.except(:attribute_value, :name))
          attribute1.name = title_attribute_1
  
          if product.invalid? || attribute1.invalid?
            return [false, product]
          else
            create = product.save
            create_attribute_1 = attribute1.save
  
            list_attribute_1 = value_attribute_1[:attribute_1]
  
            count = 0
            list_attribute_1.each do |value_1|
              product_attribute_value_1 = attribute1.product_attribute_values.build
  
              attribute_value = AttributeValue.new(
                attribute_1: value_1, 
                price_attribute_product: value_attribute_1[:price_attribute_product][count],
                stock: value_attribute_1[:stock][count]
              )
              attribute_value.save
              count += 1
  
              product_attribute_value_1.attribute_value_id = attribute_value.id
              product_attribute_value_1.save
            end
            return [true, product]
          end
        end
      else
        title_attribute_1 = product_attribute_1[:name][0]
        title_attribute_2 = product_attribute_2[:name][0]
        ActiveRecord::Base.transaction do
          value_attribute_1 = product_attribute_1[:attribute_value]
          value_attribute_2 = product_attribute_2[:attribute_value]
                  
          attribute1 = product.product_attributes.build(product_attribute_1.except(:attribute_value, :name))
          attribute1.name = title_attribute_1
          attribute2 = product.product_attributes.build(name: title_attribute_2)
  
          if product.invalid? || attribute1.invalid? || attribute2.invalid?
            return [create = false, product]
          else
            create = product.save
            create_attribute_1 = attribute1.save
            create_attribute_2 = attribute2.save
  
            list_attribute_1 = value_attribute_1[:attribute_1]
            list_attribute_2 = value_attribute_2[:attribute_2]
  
            count = 0
            list_attribute_1.each do |value_1|
              list_attribute_2.each do |value_2|
                
                product_attribute_value_1 = attribute1.product_attribute_values.build
                product_attribute_value_2 = attribute2.product_attribute_values.build
  
                attribute_value = AttributeValue.new(
                  attribute_1: value_1, attribute_2: value_2, 
                  price_attribute_product: value_attribute_1[:price_attribute_product][count],
                  stock: value_attribute_1[:stock][count]
                )
                attribute_value.save
                count += 1
  
                product_attribute_value_1.attribute_value_id = attribute_value.id
                product_attribute_value_2.attribute_value_id = attribute_value.id
  
                product_attribute_value_1.save
                product_attribute_value_2.save
              end
            end
            return [true, product]
          end
        end
      end
    end
  end

  private

  attr_accessor :product_params
end