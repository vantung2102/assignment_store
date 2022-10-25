class Admin::Products::UpdateService < ApplicationService
  def initialize(product, product_params)
      @product = product
      @product_params = product_params
  end

  def call
    product_attribute_1 = product_params[:product_attribute_1]
    product_attribute_2 = product_params[:product_attribute_2]

    if product_attribute_1.nil? && product_attribute_2.nil?
      update = product.update(product_params)
      return [update, product]
    else
      attribute = product.product_attributes
      attribute_values = attribute[0].attribute_values

      if product_attribute_1.present? && product_attribute_2.nil?
        ActiveRecord::Base.transaction do
          update_product= product.update(product_params.except(:product_attribute_1))

          title_attribute_1 = product_attribute_1[:name][0]
          attribute.update(name: title_attribute_1)

          attribute_values = attribute[0].attribute_values
          values = product_attribute_1[:attribute_value]

          count = 0
          attribute_values.each do |item|
            item.update(  
              attribute_1: values[:attribute_1][count], 
              price_attribute_product: values[:price_attribute_product][count],
              stock: values[:stock][count]
            )
            count += 1
          end
          return [true, product]
        end
      elsif product_attribute_1.present? && product_attribute_2.present?

        if product_params[:update][:destroy]
          product_params[:update][:destroy][:attribute_value].each do |item|
            
            binding.pry
            
            attribute_values.where('attribute_1=? OR attribute_2=?', item, item).destroy_all
          end
        end
        
        # binding.pry
        
        update_product= product.update(product_params.except(:product_attribute_1, :product_attribute_2))

        title_attribute_1 = product_attribute_1[:name][0]
        title_attribute_2 = product_attribute_1[:name][1]
        
        attribute[0].update(name: title_attribute_1)
        attribute[1].update(name: title_attribute_2)

        values_1 = product_attribute_1[:attribute_value]
        values_2 = product_attribute_2[:attribute_value]
        
        attribute_1 = values_1[:attribute_1].reject(&:empty?)
        attribute_2 = values_2[:attribute_2].reject(&:empty?)
        count = 0
        
        # attribute_values = attribute[0].attribute_values

        attribute_1.each do |item_1|
          attribute_2.each do |item_2|
            attribute_values[count].update(
              attribute_1: item_1,
              attribute_2: item_2,
              price_attribute_product: values_1[:price_attribute_product][count],
              stock: values_1[:stock][count]
            )
            count += 1
          end
        end
      end
    end
  end

  private

  attr_accessor :product, :product_params
end