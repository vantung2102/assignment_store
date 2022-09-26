class ProductDetailController < ApplicationController
  def show
    @categories = Category.show_categories.include_categories
    @brands = Brand.all.include_products

    @product = Product.with_attached_images.includes(:attribute_product_titles).friendly.find(params[:id])
  end
end
