class Client::Stripe::PaymentIntent < ApplicationService
  def initialize(user, shipping, code_voucher)
    @user = user
    @shipping = shipping
    @code_voucher = code_voucher
  end

  def call
    total, products, address = Client::Stripe::GetInfoOrder.call(user)

    voucher = Voucher.find_by(code: code_voucher) if code_voucher.present?
    total_payment = (total.to_i - shipping.to_i - (voucher.nil? ? 0 : voucher.cost.to_i))
    code = voucher.nil? ? '' : voucher.code

    intent = Stripe::PaymentIntent.create({
                                            amount: total_payment,
                                            currency: 'usd',
                                            description: code,
                                            metadata: {
                                              shipping: shipping,
                                              code_voucher: code
                                            }
                                          })

    [intent, address]
  end

  private

  attr_accessor :shipping, :user, :code_voucher
end
