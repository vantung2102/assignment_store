module ApplicationHelper
  include Pagy::Frontend

  def raicon_data_attributes
    {
      data: {
        'raicon-controller': controller_path,
        'raicon-action': action_name
      }
    }
  end

  def get_stock_product(product)
    attributes = product.product_attributes.includes(:attribute_values)
    return product.quantity if attributes.blank?
    
    return attributes[0].attribute_values.sum(&:stock) if attributes[1].nil?
    attributes[0].attribute_values.sum(&:stock) + attributes[1].attribute_values.sum(&:stock)
  end

  def get_product_cart(product, item)
    return { price: product.price_cents, discount: product.discount, stock: product.quantity } if item['id_1'].nil?
    
    attributes = product.product_attributes.includes(:attribute_values)
    if item['id_1'].present? && item['id_2'].present?
      value = attributes[1].attribute_values.where(attribute_2: item['val_2']).find_by(attribute_1: item['val_1'])
      
      stock = value.stock
      price = value.price_attribute_product

      return {
        name: { attr1: attributes[0].name, attr2:  attributes[1].name },
        stock: stock,
        price: price,
        discount: product.discount,
        attribute_value: { attr1: value.attribute_1, attr2:  value.attribute_2 }
      }
    end

    if item['id_1'].present?
      value = attributes[0].attribute_values.find_by(attribute_1: item['val_1'])
      return {
        name: attributes[0].name,
        stock: value.stock,
        price: value.price_attribute_product,
        discount: product.discount,
        attribute_value: value.attribute_1
      }
    end

  end

  def get_price(product)
    attributes = product.product_attributes.includes(:attribute_values)
    return product.price.to_f if attributes.blank?
    return attributes[0].attribute_values.min_by(&:price_attribute_product).price_attribute_product
  end
end
