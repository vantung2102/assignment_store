class Client::Address::CreateService < ApplicationService
  def initialize(address_params, user)
    @address_params = address_params
    @user = user
  end

  def call
    address = user.addresses.build(address_params)

    create = address.save
    message = create ? 'Address was successfully created.' : 'Address was failure created.'
    [create, address, message]
  end

  private

  attr_accessor :address_params, :user
end
