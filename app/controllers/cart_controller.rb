class CartController < ApplicationController
  def show
    if params[:carts].nil? && cookies[:add_to_cart].nil?
      render :show
    elsif params[:carts]
      carts_json = params[:carts].values.to_json

      @products = Client::Cart::ShowCartService.call(carts_json)
      html = render_to_string(partial: "cart/shared/list_product_cart", :layout => false)
      render json: { status: 200, html: html, carts: params[:carts].values }
    else    
      @products = Client::Cart::ShowCartService.call(cookies[:add_to_cart])
    end
  end

  def checkout
    @order = Order.new
  end
end
