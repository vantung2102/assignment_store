class Client::Checkout::VnpayService  < ApplicationService
  def initialize(return_url)
    @return_url = return_url
  end

  def call
    
    vnp_tmncode = ENV["VNP_TMNCODE"]
    vnp_hash_secret = ENV["VNP_HASH_SECRET"]
    vnp_url = ENV["VNP_URL"]
    vnp_txnref = 1
    vnp_order_info = "Thanh toan mua hang"
    vnp_order_type = "190000"
    vnp_amount = 10000
    vnp_local = "vn"
    binding.pry
    vnp_ipadd = request.remote_ip
    
   input_data = {
     "vnp_Amount" => vnp_amount,
     "vnp_Command" => "pay",
     "vnp_CreateDate" => DateTime.current.strftime("%Y%m%d%H%M%S"),
     "vnp_CurrCode" => "VND",
     "vnp_IpAddr" => vnp_ipadd,
     "vnp_Locale" => vnp_local,
     "vnp_OrderInfo" => vnp_order_info,
     "vnp_OrderType" => vnp_order_type,
     "vnp_ReturnUrl" => return_url,
     "vnp_TmnCode" => vnp_tmncode,
     "vnp_TxnRef" => vnp_txnref,
     "vnp_Version" => "2.0.0",
   }
   original_data = input_data.map do |key, value|
     "#{key}=#{value}"
   end.join("&")

   vnp_url = vnp_url + "?" + input_data.to_query
   vnp_security_hash = Digest::SHA256.hexdigest(vnp_hash_secret + original_data)
   vnp_url += '&vnp_SecureHashType=SHA256&vnp_SecureHash=' + vnp_security_hash
   vnp_url
  end
  
  private

  attr_accessor :return_url
end
