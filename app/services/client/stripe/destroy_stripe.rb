class Client::Stripe::DetroyOrder < ApplicationService
  def initialize(charge)
    @charge = charge
  end

  def call
    billing_details = charge.billing_details
    receipt_url = charge.receipt_url

    user = User.find_by(email: billing_details.email)
    order = user.orders.find_by(token: charge.payment_intent)
    order.destroy if order
  end

  private

  attr_accessor :charge
end
