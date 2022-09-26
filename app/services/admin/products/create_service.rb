class Admin::Products::CreateService < ApplicationService
  def initialize(product_params)
      @product_params = product_params
  end

  def call
    attributes = product_params[:product_attributes_attributes].values
    product = Product.new(product_params.except(:product_attributes_attributes))

    attributes.each do |type_attribute|
      title = type_attribute["attribute_product_title_id"]
      
      if title.blank?
        create = product.save
        return [create, product, attribute = nil, value = nil]
      else
        attribute = product.product_attributes.build(attribute_product_title_id: title)
        values = type_attribute["attribute_values_attributes"]

        unless values.nil?
          values = values.values

          values.each do |item_value|
            value = attribute.attribute_values.build(value: item_value["value"], price_attribute_product: item_value["price_attribute_product"])

            if product.invalid? || attribute.invalid? || value.invalid?
              return [create = false, product, attribute, value]
            else
              Product.transaction do
                ProductAttribute.transaction do
                  AttributeValue.transaction do
                    create = product.save         
                    product_attribute = attribute.save
                    attribute_value = value.save
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  private

  attr_accessor :product_params
end