class AddressesController < ApplicationController
  def index
    @address = Address.new
  end

  def new
    @address = Address.new
  end
end
