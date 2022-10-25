class ProductDetailController < ApplicationController
  def show
    @categories = Category.show_categories.include_categories
    @brands = Brand.all.include_products
    @product = Product.with_attached_images.friendly.find(params[:id])

    @product_attributes = @product.product_attributes.includes(:attribute_values)
    # if @product.product_attributes.present?

    #   if @product_attributes.length == 1
        
    #   else
    #   end
    # end
    
    # binding.pry
    
    @comments = @product.comments.where(comment_id: nil)
  end
end
