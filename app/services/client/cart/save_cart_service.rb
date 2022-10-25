class Client::Cart::SaveCartService < ApplicationService
  def initialize(carts_json, user)
    @carts_json = carts_json
    @user = user
  end

  def call
    user.cart.destroy unless user.cart.nil?
    cart = JSON.parse(carts_json)
    ids = cart.map{ |item| item['id'].to_i }.uniq
    products = Product.where(id: ids)
    new_cart = Cart.new(user_id: user.id)
        
    ActiveRecord::Base.transaction do
      new_cart.save
      cart.each do |item|
        next if products.find_by(id: item['id']).nil?

        product = products.find_by(id: item['id'])

        if item['id_1'].present?
          attribute = ProductAttribute.find_by(id: item['id_1']).attribute_values
          if item['id_2'].nil?
            value = attribute.find_by(attribute_1: item['val_1'])
          else
            value = attribute.where(attribute_1: item['val_1']).find_by(attribute_2: item['val_2'])
          end
        end

        cart_item = new_cart.cart_items.build( product_id: product.id, quantity: item['amount'] )
        cart_item.attribute_value_id = value.id if value.present?
        cart_item.save
      end
    end
    
  end

  private

  attr_accessor :carts_json, :user
end