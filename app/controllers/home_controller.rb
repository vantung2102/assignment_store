class HomeController < ApplicationController
  def index
    @categories = Category.show_categories.include_categories
    @brands = Brand.all.include_products

    if params[:category].nil? && params[:brand].nil? && params[:page].nil? && params[:search].nil?
      @products = Product.with_attached_images.includes(:product_attributes).limit(PER_PAGE)
    elsif params[:category].present?
      @products = Client::Home::ProductsCategoryService.call(params[:category])
    elsif params[:brand].present?
      @products = Client::Home::ProductsBrandService.call(params[:brand])
    elsif params[:page].present?
      @products, @status = Client::Home::LoadMoreService.call(params[:page])
    elsif params[:search].present?
      @product = Product.query_search(:title, params[:search]).order(created_at: :desc)
    end
  end

  def change_category
    @products = Client::Home::ProductsCategoryService.call(params[:slug])

    html = render_to_string partial: 'home/shared/features_items', layout: false
    render json: { status: 200, message: 'Successfully', html: html }
  end

  def change_brand
    @products = Client::Home::ProductsBrandService.call(params[:slug])
    html = render_to_string partial: 'home/shared/features_items', layout: false

    render json: { status: 200, message: 'Successfully', html: html }
  end

  def load_more_product
    total_page = (Product.count.to_f / PER_PAGE).ceil
    page = params[:page].nil? ? 1 : params[:page].to_i

    if (page >= 1) && (page <= total_page)
      offset = page.to_i * PER_PAGE
      @products = Product.limit(PER_PAGE).offset(offset)
      html = render_to_string partial: 'home/shared/list_products', layout: false

      next_page = page + 1 == total_page ? 'last_page' : ''
    else
      next_page = 'error_page'
    end

    render json: { status: 200, message: 'Successfully', html: html, page: next_page }
  end

  def search_product
    @products = Product.query_search(:title, params[:search]).order(created_at: :desc)

    html = render_to_string partial: 'home/shared/features_items', layout: false
    render json: { status: 200, message: 'Successfully', html: html }
  end

  PER_PAGE = 6
end
