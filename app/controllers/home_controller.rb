class HomeController < ApplicationController
  def index
    @categories = Category.show_categories.limit(10)
    @brands = Brand.all.limit(10)

    if params[:category].nil? && params[:brand].nil? && params[:page].nil?
      @products = Product.all.limit(PER_PAGE)
    else
      if !params[:category].nil?
        @products = Client::Home::ProductsCategoryService.call(params[:category])
      elsif !params[:brand].nil?
        @products = Client::Home::ProductsBrandService.call(params[:brand])
      elsif !params[:page].nil?
        @products, @status = Client::Home::LoadMoreService.call(params[:page])
      end
    end
  end

  def change_category
    @products = Client::Home::ProductsCategoryService.call(params[:slug])

    html = render_to_string partial: "home/shared/features_items", :layout => false
    render json: { status: 200, message: "Successfully", html: html }
  end

  def change_brand
    @products = Client::Home::ProductsBrandService.call(params[:slug])

    html = render_to_string partial: "home/shared/features_items", :layout => false
    render json: { status: 200, message: "Successfully", html: html }
  end

  def load_more_product
    @products = Client::Home::LoadMoreService.call(params[:page])

    total_page = (Product.count.to_f / PER_PAGE).ceil
    page = params[:page].nil? ? 1 : params[:page].to_i
    
    if (page >= 1) && (page <= total_page)
      offset = page.to_i * PER_PAGE
      @products = Product.limit(PER_PAGE).offset(offset)
      html = render_to_string partial: "home/shared/list_products", :layout => false

      next_page = page + 1 == total_page ? "last_page" : ""
    else
      next_page = "error_page"
    end

    render json: { status: 200, message: "Successfully", html: html, page: next_page}
  end

  private

  PER_PAGE = 6
end