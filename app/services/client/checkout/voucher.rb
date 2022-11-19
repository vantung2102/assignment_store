class Client::Checkout::Voucher < ApplicationService
  def initialize(user, code)
    @user = user
    @code = code
  end

  def call
    voucher = Voucher.find_by(code: code)

    return [false, 'Voucher invaild'] if voucher.nil?

    return [false, 'Voucher expired'] if voucher.end_time < DateTime.now
    return [false, 'Discounted items are sold out'] if voucher.discount_mount <= voucher.apply_amount
    if user.user_vouchers.nil? && user.user_vouchers.find_by(id: voucher.id).checked == true
      return [false, 'You have used this voucher']
    end

    [true, "You have successfully applied the discount code #{voucher.name}", voucher.cost]
  end

  private

  attr_accessor :user, :code
end
