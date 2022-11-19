class Admin::Products::CreateService < ApplicationService
  def initialize(product_params)
    @product_params = product_params
  end

  def call
    ActiveRecord::Base.transaction do
      product = Product.new(product_params.except(:product_attribute_1, :product_attribute_2))
      product.save!

      product_attribute_1 = product_params[:product_attribute_1]
      product_attribute_2 = product_params[:product_attribute_2]

      return [true, product] if product_attribute_1.nil? && product_attribute_2.nil?

      [product_attribute_1, product_attribute_2].compact.each do |processing_product_attribute|
        name = processing_product_attribute[:name]
        product_attribute = product.product_attributes.new(name: name, images: product_attribute_1[:images])

        binding.pry

        product_attribute.save!
      end

      product_attribute_values_1 = product_attribute_1&.dig(:attribute_value)
      product_attribute_values_2 = product_attribute_2&.dig(:attribute_value)

      list_attribute_title_1 = product_attribute_values_1&.dig(:attribute)
      list_attribute_title_2 = product_attribute_values_2&.dig(:attribute)

      if product_attribute_values_2.nil?
        return [false, product] if list_attribute_title_1.length < list_attribute_title_1.uniq.length

        list_attribute_title_1.each_with_index do |attribute_1_title, index|
          created_attribute_value = AttributeValue.create!(
            attribute_1: attribute_1_title,
            price_attribute_product: product_attribute_values_1[:price_attribute_product][index],
            stock: product_attribute_values_1[:stock][index]
          )
          product.product_attributes[0].product_attribute_values.create!(attribute_value_id: created_attribute_value.id)
        end
        return [true, product]
      else
        return [false, product] if list_attribute_title_2.length < list_attribute_title_2.uniq.length

        count = 0
        list_attribute_title_1.each do |attribute_1_title|
          list_attribute_title_2.each do |attribute_2_title|
            created_attribute_value = AttributeValue.create!(
              attribute_1: attribute_1_title, attribute_2: attribute_2_title,
              price_attribute_product: product_attribute_values_1[:price_attribute_product][count],
              stock: product_attribute_values_1[:stock][count]
            )

            binding.pry

            product.product_attributes[0].product_attribute_values.create!(attribute_value_id: created_attribute_value.id)
            product.product_attributes[1].product_attribute_values.create!(attribute_value_id: created_attribute_value.id)
            count += 1
          end
        end
        return [true, product]
      end
    rescue StandardError => e
      return [false, product]
    end
  end

  private

  attr_accessor :product_params
end
