class Client::Home::LoadMoreService < ApplicationService
  def initialize(params_page)
    @params_page = params_page
  end

  def call
    total_page = (Product.count.to_f / PER_PAGE).ceil
    page = params_page.nil? ? 1 : params_page.to_i

    if (page >= 1) && (page <= total_page)
      offset = page.to_i * PER_PAGE
      products = Product.with_attached_images.limit(offset)
      status = nil
    else
      products = Product.with_attached_images.limit(PER_PAGE)
      status = 'error_page'
    end
    [products, status]
  end

  private

  PER_PAGE = 6
  attr_accessor :params_page
end
