class HomeController < ApplicationController
  def index
    @categories = Category.show_categories.limit(10)

    if params[:category].nil?
      @products = Product.all.limit(6)
    else
      @products = User::ProductsCategoryService.call(params[:category])
    end
  end

  def change_category
    @products = User::ProductsCategoryService.call(params[:slug])

    html = render_to_string partial: "home/shared/features_items", :layout => false
    render json: { status: 200, message: "Successfully", html: html }
  end
end