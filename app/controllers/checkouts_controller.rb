class CheckoutsController < ApplicationController
  include Stud
  before_action :authenticate_user!
  before_action :authenticate_user
  before_action :check_cart

  def show
    @cart = exists_product?(JSON.parse(cookies[:add_to_cart]))
    @addresses = current_user.addresses
    @address_default = @addresses.find_by(status: true)

    Client::Cart::SaveCartService.call(JSON.parse(cookies[:add_to_cart]), current_user)
  end

  def success; end

  def error; end

  def info_checkout
    code, message, data = Client::Checkout::GetInfo.call(current_user, cookies[:add_to_cart])
    render json: { status: code, message: message, data: data }
  end

  def voucher
    result, message, cost = Client::Checkout::Voucher.call(current_user, params[:voucher])
    render json: { status: 200, result: result, message: message, cost: cost }
  end

  def payment
    case params[:payment_gateway]
    when 'STRIPE'
      html = render_to_string partial: 'checkouts/shared/stripe', layout: false
      data = { method: 'STRIPE', html: html }
    when 'MOMO'
      create, order = Client::Order::CreateService.call(
        current_user,
        Order.statuses[:paying_excute],
        Order.payment_gateways[:momo],
        params[:shipping],
        params[:voucher],
        Order.new_token
      )

      if create
        url = Client::Checkout::MomoService.call(current_user, order)
        data = { method: 'MOMO', url: url }
        status = 200
        message = 'successfully'
      else
        status = 500
        essage = 'Invalid when payment'
      end
    when 'COD'
      create, @order = Client::Order::CreateService.call(
        current_user,
        Order.statuses[:pending],
        Order.payment_gateways[:cod],
        params[:shipping],
        params[:voucher],
        Order.new_token
      )

      if create
        html = render_to_string partial: 'checkouts/success', layout: false
        data = { method: 'COD', html: html }
        status = 200
        message = 'successfully'
      else
        status = 500
        message = 'Invalid when payment'
      end
    else
      status = 400
      message = 'Invalid when payment'
    end

    render json: { status: status, message: message, data: data }
  end

  def stripe_payment; end

  def payment_with_stripe
    intent, address = Client::Stripe::PaymentIntent.call(current_user, params[:shipping], params[:voucher])

    data = {
      key_secret: intent,
      address: address,
      user: current_user,

      url: {
        success: success_checkout_url,
        error: error_checkout_url
      }
    }
    render json: { status: 200, message: 'successfully', data: data }
  end

  def check_order_stripe
    @order = Order.find_by(token: params[:payment_intent_id])
    status = @order.nil? ? 500 : 200

    html = render_to_string partial: 'checkouts/success', layout: false
    render json: { status: status, html: html }
  end

  private

  def check_cart
    return if cookies[:add_to_cart].present?

    redirect_to root_path
  end

  def exists_product?(cart)
    ids = cart.map { |item| item['id'].to_i }.uniq
    products = Product.where(id: ids).group_by(&:id).keys
    cart.select { |el| products.include?(el['id'].to_i) }
  end
end
