module HomeHelper
  def discount(price, discount)
    (price.to_f - discount.to_f).round(2)
  end

  def last_page?(_products, params, status)
    if status == 'error_page'
      true
    elsif params[:page].present?
      params[:page].to_i < (Product.count.to_f / 6).ceil
    else
      params[:page].nil?
      params[:category].present? || params[:brand].present? ? false : true
    end
  end

  def locale(paramater, en, vi)
    paramater == 'en' || paramater.nil? ? en : vi
  end
end
