class HomeController < ApplicationController
  def index
    feature_items = Product.all
    categories = Category.show_categories.limit(10)

    @products = []

    if params[:category].nil?
      @products = Product.all.limit(6)
    else
      @products = User::ProductsCategoryService.call(params[:category])
    end

    @data = {
      feature_items: feature_items,
      categories: categories
    }
  end

  def change_category
    @products = User::ProductsCategoryService.call(params[:slug])

    html = render_to_string partial: "home/shared/features_items", :layout => false
    render json: { status: 200, html: html }
  end
end