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
    @address = Address.new
  end

  # def create_address
    
  #   # binding.pry
    
  #   @address = Address.new(address_params)
  #   create = @address.save
  #   if create
  #   else
  #     # redirect_to checkout_cart_path
  #     render :checkout
  #   end
  # end

  private

  def address_params
    params.require(:address).permit(:fullname, :phone_number, :province_id, :district_id, :ward_id, :addressDetail)
  end
end
