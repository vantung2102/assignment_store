class Client::Order::CreateService < ApplicationService
  def initialize(user, status, payment_gateway, shipping, code_voucher, token)
    @user = user
    @status = status
    @payment_gateway = payment_gateway
    @shipping = shipping
    @code_voucher = code_voucher
    @token = token
  end

  def call
    total, products, address = Client::Stripe::GetInfoOrder.call(user)
    return [false] if address.nil?

    cart = user.cart.cart_items
    voucher = Voucher.find_by(code: code_voucher) if code_voucher.present?
    attribute_value_ids = cart.group_by(&:attribute_value_id).keys.uniq
    attribute_values = AttributeValue.where(id: attribute_value_ids)

    order = Order.new(
      status: status,
      address_id: address.id,
      payment_gateway: payment_gateway,
      user_id: user.id,
      total: total - shipping.to_f - (voucher.nil? ? 0 : voucher.cost.to_f),
      token: token,
      discount: voucher.nil? ? 0 : voucher.cost.to_f,
      shipping: shipping
    )

    ActiveRecord::Base.transaction do
      if voucher.present?
        begin
          update_voucher = voucher.update(apply_amount: voucher.apply_amount + 1)
          user_voucher = user.user_vouchers.build(voucher_id: voucher.id, checked: true)
          user_voucher.save
        rescue ActiveRecord::StatementInvalid => e
          return false
        end
      end

      create = order.save

      cart.each do |cart_item|
        order_item = order.order_items.build(
          product_id: cart_item.product_id,
          quantity: cart_item.quantity
        )

        if cart_item.attribute_value_id.present?
          attribute_value = attribute_values.find_by(id: cart_item.attribute_value_id)
          if attribute_value.stock < cart_item.quantity
            raise ActiveRecord::Rollback
            return [false, order]
          else
            order_item.attribute_value_id = cart_item.attribute_value_id
          end
        else
          product = products.find_by(id: cart_item.product_id)

          if product.quantity < cart_item.quantity
            raise ActiveRecord::Rollback
            return [false, order]
          end
        end
        order_item.save
      end

      if create
        order.order_items.each do |order_item|
          if order_item.attribute_value_id.nil?
            product = Product.find_by(id: order_item.product_id)
            quantity = product.quantity.to_i - order_item.quantity.to_i
            product.update(quantity: quantity)
          else
            product = AttributeValue.find_by(id: order_item.attribute_value_id)
            quantity = product.stock.to_i - order_item.quantity.to_i
            product.update(stock: quantity)
          end
        end
        user.cart.destroy
      end

      [create, order]
    end
  end

  private

  attr_accessor :user, :status, :payment_gateway, :shipping, :code_voucher, :token
end
