class Admin::Vouchers::DestroyService < ApplicationService
  def initialize(voucher)
    @voucher = voucher
  end

  def call
    voucher&.destroy ? [true, 'Voucher was successfully destroy.'] : [false, 'Voucher was failure destroy.']
  end

  private

  attr_accessor :voucher
end
