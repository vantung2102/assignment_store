class Client::Cart::ShowCartService < ApplicationService
  def initialize(carts_json)
    @carts_json = carts_json
  end

  def call    
    carts = JSON.parse(carts_json)
    ids = []
    carts.each do |cart|
      ids << cart['id'].to_i 
    end
    
    Product.where(id: ids)
  end

  private

  attr_accessor :carts_json
end