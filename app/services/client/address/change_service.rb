class Client::Address::ChangeService < ApplicationService
  def initialize(change_address_params, user)
    @change_address_params = change_address_params
    @user = user
  end

  def call
    addresses = user.addresses
    addresses.update_all(status: false)
    item = addresses.find(change_address_params)

    item.update!(status: true)
  rescue StandardError => e
    false
  end

  private

  attr_accessor :change_address_params, :user
end
