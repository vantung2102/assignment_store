class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authorize_admin!, only: %i[ update destroy ]

  def index
      products = Category.all

      @data = {
          categories: products
      }
  end

  def show;end

  def new
      @product = Product.new
  end

  def create
    create, message = Admin::products::CreateService.call(product_params)

    status = create ? :success : :danger
    flash[status] = message
    redirect_to admin_products_path
  end

  def edit;end

  def update
    update, message = Admin::Products::UpdateService.call(@product, product_params)

    status = update ? :success : :danger
    flash[status] = message
    redirect_to edit_admin_product_url(@product)
  end

  def destroy
    destroy, message = Admin::products::DestroyService.call(@product)

    status = destroy ? :success : :danger
    flash[status] = message
    redirect_to admin_products_path
  end

  private

  def set_product
    @product = product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :meta_title, :content, :product_id)
  end

  def authorize_admin!
    authorize @user
  end
end