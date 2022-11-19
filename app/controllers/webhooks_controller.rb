class WebhooksController < ApplicationController
  include Stud
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = 'whsec_LlSjTY6YvBsoYyUIvHJI37e3HHLhSQw8'

    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      render json: { status: 400, message: 'Invalid payload' }
    rescue Stripe::SignatureVerificationError => e
      render json: { status: 400, message: 'Invalid signature' }
    end

    case event.type
    when 'payment_intent.succeeded'
      payment_intent = event.data.object
      create, order = Client::Stripe::CreateOrder.call(payment_intent)

      render json: { status: 500, message: 'Invalid' } if create == false
    when 'payment_method.attached'
      payment_method = event.data.object
    when 'charge.succeeded'
      charge = event.data.object
      curr_order = Order.find_by(token: charge.payment_intent)

      if curr_order.nil?
        stop = 0
        interval(1.seconds) do
          Order.connection.query_cache.clear
          curr_order = Order.find_by(token: charge.payment_intent)
          Stud.stop! unless curr_order.nil?

          if stop > 5
            Stud.stop!
            render json: { status: 500, message: 'Invalid' }
          end
          stop += 1
        end
      end
      Client::Stripe::UpdateOrder.call(charge, Order.statuses[:paid])
    when 'charge.failed'
      charge = event.data.object
      Client::Stripe::UpdateOrder.call(charge, Order.statuses[:failed])
    when 'charge.refunded'
      charge = event.data.object
      Client::Stripe::UpdateOrder.call(charge, Order.statuses[:canceled])
    end

    render json: { status: 200, message: 'successfully' }
  end

  def momo
    even = params
    stop = 0
    interval(1.seconds) do
      Order.connection.query_cache.clear
      order = Order.find_by(token: even[:orderId])
      Stud.stop! unless order.nil?

      if stop > 5
        Stud.stop!
        render json: { status: 500, message: 'Invalid' }
      end
      stop += 1
    end

    if even[:resultCode] == 0
      order.update(status: Order.statuses[:paid])
    elsif even[:resultCode] == 90_000

    else
      order.update(status: Order.statuses[:failed])
    end

    render json: { status: 200, message: 'successfully' }
  end
end
