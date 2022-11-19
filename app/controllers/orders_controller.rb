class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user
  before_action :set_order, only: %i[order_detail show_order_detail]

  def show
    @pagy, @orders = pagy(current_user.orders, items: 5)
  end

  def order_detail
    @address = Address.find_by(id: @order.address_id)

    html = render_to_string partial: 'orders/shared/order_detail', layout: false
    render json: { status: 200, message: 'successfully', html: html }
  end

  def show_order_detail
    @address = Address.find_by(id: @order.address_id)
  end

  def refund_stripe
    refund = Stripe::Refund.create({ payment_intent: params[:code] })
    render json: { status: 200, messsage: 'successfully', refund: refund }
  end

  private

  def set_order
    @order = Order.find_by(token: params[:code])
  end
end
