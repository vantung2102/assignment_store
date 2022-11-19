class Client::Checkout::GetInfo < ApplicationService
  def initialize(user, carts_json)
    @user = user
    @carts_json = carts_json
  end

  def call
    address = user.addresses.find_by(status: true)

    cart = JSON.parse(carts_json)
    ids = cart.map { |item| item['id'].to_i }.uniq
    products = Product.where(id: ids)

    total = 0
    cart.each do |item|
      product = products.find(item['id'])

      price = product.price
      if item['id_1'].present?
        attribute = ProductAttribute.find_by(id: item['id_1']).attribute_values
        price = if item['id_2'].nil?
                  attribute.find_by(attribute_1: item['val_1']).price_attribute_product
                else
                  attribute.where(attribute_1: item['val_1']).find_by(attribute_2: item['val_2']).price_attribute_product
                end
      end
      total += (price.to_f - product.discount)
    end

    data_services = {
      shop_id: shop_params[:id],
      from_province: shop_params[:province_id],
      from_district: shop_params[:district_id],
      from_ward: shop_params[:ward_id],
      to_province: address[:province_id],
      to_district: address[:district_id],
      to_ward: address[:ward_id]
    }

    data_fee_charge = {
      insurance_value: total.to_i,
      from_province_id: shop_params[:province_id],
      from_district_id: shop_params[:district_id],
      from_ward_code: shop_params[:ward_id],
      to_province_id: address[:province_id],
      to_district_id: address[:district_id],
      to_ward_code: address[:ward_id],
      height: 15,
      length: 15,
      weight: 1000,
      width: 15
    }

    res_services = HTTParty.post(
      'https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services',
      body: data_services.to_json,
      headers: { 'Content-Type' => 'application/json', 'token' => shop_params[:token] }
    )
    return [500, 'Invaild Shipping'] if res_services['code'] != 200

    data_fee_charge[:service_id] = res_services['data'][0]['service_id']

    res_fee_charge = HTTParty.post(
      'https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee',
      body: data_fee_charge.to_json,
      headers: { 'Content-Type' => 'application/json', 'token' => shop_params[:token] }
    )

    if res_fee_charge['code'] == 200
      data = { fee: (res_fee_charge['data']['total'].to_f / 23_000), total: total }
      [200, 'Successfully', data]
    else
      [500, 'Invaild Shipping']
    end
  end

  private

  attr_accessor :user, :carts_json

  def shop_params
    {
      token: 'cbd8025f-55e4-11ed-ad26-3a4226f77ff0',
      id: 3_395_594,
      province_id: 202,
      district_id: 1459,
      ward_id: 22_212
    }
  end
end
