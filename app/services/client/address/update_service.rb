class Client::Address::UpdateService < ApplicationService
  def initialize(address, address_params)
    @address = address
    @address_params = address_params
  end

  def call
    update = address.update(address_params)
    message = update ? 'Address was successfully updated.' : 'Address was failure updated.'
    [update, message]
  end

  private

  attr_accessor :address, :address_params
end
