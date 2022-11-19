class Client::Stripe::GetInfoOrder < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    address = user.addresses.find_by(status: true)
    cart = user.cart.cart_items

    ids = cart.group_by(&:product_id).keys
    products = Product.where(id: ids)
    total = 0
    cart.each do |cart_item|
      product = products.find_by(id: cart_item.product_id)
      price = if cart_item.attribute_value_id.nil?
                products.find_by(id: cart_item.product_id).price_cents
              else
                AttributeValue.find_by(id: cart_item.attribute_value_id).price_attribute_product
              end
      total += (price - product.discount)
    end

    [total, products, address]
  end

  private

  attr_accessor :carts, :user
end
