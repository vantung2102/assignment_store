class Admin::Products::UpdateService < ApplicationService
  def initialize(product, product_params)
    @product = product
    @product_params = product_params
  end

  def call
    ActiveRecord::Base.transaction do
      product.update!(product_params.except(:product_attribute_1, :product_attribute_2, :update))

      product_attribute_1 = product_params[:product_attribute_1]
      product_attribute_2 = product_params[:product_attribute_2]

      return true if product_attribute_1.nil? && product_attribute_2.nil?

      product_attribute_values_1 = product_attribute_1&.dig(:attribute_value)
      product_attribute_values_2 = product_attribute_2&.dig(:attribute_value)

      list_attribute_title_1 = product_attribute_values_1&.dig(:attribute)
      list_attribute_title_2 = product_attribute_values_2&.dig(:attribute)

      attribute_values = product.product_attributes[0].attribute_values
      update_product = product_params[:update]
      if product_attribute_values_2.nil?
        return false if list_attribute_title_1.length < list_attribute_title_1.uniq.length

        product.product_attributes[0].update!(name: product_attribute_1[:name])
        if product_attribute_1&.dig(:images).present?
          product.product_attributes[0].update!(images: product_attribute_1[:images])
        end

        if update_product
          if update_product[:destroy] && update_product[:insert].nil?
            update_product[:destroy][:attribute_value].each do |item|
              product.product_attributes[0].attribute_values.where(attribute_1: item).destroy_all
            end
          elsif update_product[:insert]
            attribute_values.destroy_all

            list_attribute_title_1.each_with_index do |attribute_1_title, index|
              created_attribute_value = AttributeValue.create!(
                attribute_1: attribute_1_title,
                price_attribute_product: product_attribute_values_1[:price_attribute_product][index],
                stock: product_attribute_values_1[:stock][index]
              )

              attribute_values.create!(attribute_value_id: created_attribute_value.id)
            end
          end
          return true
        end

        list_attribute_title_1.each_with_index do |attribute_1_title, index|
          attribute_values[index].update!(
            attribute_1: attribute_1_title,
            price_attribute_product: product_attribute_values_1[:price_attribute_product][index],
            stock: product_attribute_values_1[:stock][index]
          )
        end
      else
        return false if list_attribute_title_2.length < list_attribute_title_2.uniq.length

        if product_attribute_1&.dig(:images).present?
          product.product_attributes[0].update!(images: product_attribute_1[:images])
        end
        product.product_attributes[0].update!(name: product_attribute_1[:name], images: product_attribute_1[:images])
        product.product_attributes[1].update!(name: product_attribute_2[:name])

        if update_product
          if update_product[:destroy] && update_product[:insert].nil?
            update_product[:destroy][:attribute_value].each do |item|
              product.product_attributes[0].attribute_values.where('attribute_1=? OR attribute_2=?', item,
                                                                   item).destroy_all
            end
          elsif update_product[:insert]
            attribute_values.destroy_all

            list_attribute_title_1.each do |attribute_1_title|
              list_attribute_title_2.each do |attribute_2_title|
                attribute_values[count].create!(
                  attribute_1: attribute_1_title, attribute_2: attribute_2_title,
                  price_attribute_product: product_attribute_values_1[:price_attribute_product][count],
                  stock: product_attribute_values_1[:stock][count]
                )
                attribute_values[0].create!(attribute_value_id: created_attribute_value.id)
                attribute_values[1].create!(attribute_value_id: created_attribute_value.id)

                count += 1
              end
            end
          end
          return true
        end

        count = 0
        list_attribute_title_1.each do |attribute_1_title|
          list_attribute_title_2.each do |attribute_2_title|
            attribute_values[count].update!(
              attribute_1: attribute_1_title, attribute_2: attribute_2_title,
              price_attribute_product: product_attribute_values_1[:price_attribute_product][count],
              stock: product_attribute_values_1[:stock][count]
            )
            count += 1
          end
        end
      end
    rescue StandardError => e
      return false
    end
  end

  private

  attr_accessor :product, :product_params
end
