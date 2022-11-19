class Admin::Vouchers::UpdateService < ApplicationService
  def initialize(voucher, voucher_params)
    @voucher = voucher
    @voucher_params = voucher_params
  end

  def call
    voucher_params[:type_voucher] = voucher_params[:type_voucher].to_i
    voucher_params[:status] = voucher_params[:status] == 'true'

    update = voucher.update(voucher_params)
    message = update ? 'Voucher was successfully updated.' : 'Voucher was failure updated.'
    [update, message]
  end

  private

  attr_accessor :voucher, :voucher_params
end
