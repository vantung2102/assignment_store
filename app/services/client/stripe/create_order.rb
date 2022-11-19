class Client::Stripe::CreateOrder < ApplicationService
  def initialize(payment_intent)
    @payment_intent = payment_intent
  end

  def call
    data = payment_intent.charges.data[0]
    billing_details = data.billing_details
    user = User.find_by(email: billing_details.email)

    total, products, address = Client::Stripe::GetInfoOrder.call(user)
    cart = user.cart.cart_items

    create, order = Client::Order::CreateService.call(
      user,
      Order.statuses[:paying_excute],
      Order.payment_gateways[:stripe],
      payment_intent[:metadata].shipping,
      payment_intent[:metadata].code_voucher,
      data.payment_intent
    )

    [create, order]
  end

  private

  attr_accessor :payment_intent
end
