class Admin::Vouchers::CreateService < ApplicationService
  def initialize(voucher_params)
    @voucher_params = voucher_params
  end

  def call
    voucher_params[:type_voucher] = voucher_params[:type_voucher].to_i
    voucher_params[:status] = voucher_params[:status] == 'true'

    voucher = Voucher.new(voucher_params)
    create = voucher.save
    message = create ? 'Voucher was successfully created.' : 'Voucher was failure created.'
    [create, voucher, message]
  end

  private

  attr_accessor :voucher_params
end
