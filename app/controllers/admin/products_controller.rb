class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authorize_admin!, only: %i[ create update destroy ]

  def index
    @pagy, @products = pagy(Product.all, items: 10)
  end

  def show;end

  def new
      @product = Product.new
      @product_attributes = @product.product_attributes.build
      @attribute_values = @product_attributes.attribute_values.build
  end

  def create
    create, @product, @product_attributes, @attribute_values = Admin::Products::CreateService.call(product_params)

    if create
      flash[:success] = "Product was successfully created."
      redirect_to admin_products_path
    else
      flash[:danger] = "Product was failure created."
      render :new
    end
  end

  def edit;end

  def update
    update = Admin::Products::UpdateService.call(@product, product_params)
    
    if update
      flash[:success] = "Product was successfully updated."
      render :edit
    else
      flash[:danger] = "Product was failure updated."
      render :edit
    end
  end

  def destroy
    destroy, message = Admin::Products::DestroyService.call(@product)

    status = destroy ? :success : :danger
    flash[status] = message
    redirect_to admin_products_path
  end

  private

  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :title,
      :meta_title,
      :categories, 
      :content,
      :quantity,
      :brand_id,
      :price,
      :discount,
      images: [],
      category_ids: [],
      product_attributes_attributes: [
        :id,
        :attribute_product_title_id,
        :_destroy,
        attribute_values_attributes: [
          :id,
          :value,
          :price_attribute_product,
          :_destroy
        ]
      ]
    )
  end

  def authorize_admin!
    authorize current_user
  end
end
