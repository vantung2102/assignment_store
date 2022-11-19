class Client::Stripe::UpdateOrder < ApplicationService
  def initialize(charge, status)
    @charge = charge
    @status = status
  end

  def call
    billing_details = charge.billing_details
    receipt_url = charge.receipt_url
    OrderMailer.order_success(billing_details, receipt_url).deliver_now if status == 2

    user = User.find_by(email: billing_details.email)
    order = user.orders.find_by(token: charge.payment_intent)

    order.update(status: status)
  end

  private

  attr_accessor :charge, :status
end
