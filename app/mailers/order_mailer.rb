class OrderMailer < ApplicationMailer
  def order_success(billing_details, receipt_url)
    @billing_details = billing_details
    @receipt_url = receipt_url
    
    mail to: billing_details.email, subject: "Order Success"
  end
end