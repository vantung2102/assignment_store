class Client::Checkout::MomoService < ApplicationService
  def initialize(user, order)
    @user = user
    @order = order
  end

  def call
    endpoint = env_momo[:MOMO_END_POINT]
    partnerCode = env_momo[:MOMO_PARTNER_CODE]
    accessKey = env_momo[:MOMO_ACCESS_KEY]
    secretKey = env_momo[:MOMO_SECRET_KEY]
    orderInfo = 'pay with MoMo'
    redirectUrl = 'http://localhost:3000/'
    ipnUrl = 'https://4b4e-42-116-183-132.ap.ngrok.io/webhook/momo'
    amount = (order.total * 23_000).to_i.to_s
    orderId = order.token
    requestId = SecureRandom.uuid
    requestType = 'payWithMethod'
    extraData = ''

    rawSignature =  'accessKey=' + accessKey + '&amount=' + amount + '&extraData=' + extraData + '&ipnUrl=' + ipnUrl +
                    '&orderId=' + orderId + '&orderInfo=' + orderInfo + '&partnerCode=' + partnerCode +
                    '&redirectUrl=' + redirectUrl + '&requestId=' + requestId + '&requestType=' + requestType

    signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secretKey, rawSignature)

    jsonRequestToMomo = {
      partnerCode: partnerCode, partnerName: 'Test', storeId: 'MomoTestStore', requestId: requestId,
      amount: amount, orderId: orderId, orderInfo: orderInfo, redirectUrl: redirectUrl,
      ipnUrl: ipnUrl, lang: 'vi', extraData: extraData, requestType: requestType, signature: signature
    }

    uri = URI.parse(endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.path)
    request.add_field('Content-Type', 'application/json')
    request.body = jsonRequestToMomo.to_json

    response = http.request(request)
    result = JSON.parse(response.body)
    result['payUrl']
  end

  private

  def env_momo
    Rails.application.credentials.momo
  end

  attr_accessor :user, :order
end
