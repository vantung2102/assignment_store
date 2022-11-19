class Order < ApplicationRecord
  enum status: { pending: 0, failed: 1, paid: 2, canceled: 4, paying_excute: 5, success: 6, delivering: 7 }
  enum payment_gateway: { stripe: 0, momo: 1, vnpay: 2, paypal: 3, cod: 4 }

  has_many :order_items, dependent: :destroy

  belongs_to :address
  belongs_to :user

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
