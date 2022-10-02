module HomeHelper
  def discount(price, discount)
    price - discount
  end

  def last_page?(products, params, status)
    if status == "error_page"
      true
    elsif params[:page].present?
      params[:page].to_i < (Product.count.to_f / 6).ceil
    else params[:page].nil?
      params[:category].present? || params[:brand].present? ? false : true
    end
  end
end