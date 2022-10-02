module HomeHelper
  def discount(price, discount)
    price - discount
  end

  def last_page?(products, params_page, status)
    if status == "error_page"
      return true
    else
      params_page.to_i < (Product.count.to_f / 6).ceil && products.present?
    end
  end
end