class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authorize_admin!, only: %i[ create update destroy ]

  def index
      products = Product.all

      @data = {
        products: products
      }
  end

  def show;end

  def new
      @product = Product.new
  end

  def create
    create, @product, message = Admin::Products::CreateService.call(product_params)

    if create
      flash[:success] = message
      redirect_to admin_products_path
    else
      flash[:danger] = message
      render :new
    end
  end

  def edit;end

  def update
    update, message = Admin::Products::UpdateService.call(@product, product_params)

    status = update ? :success : :danger
    flash[status] = message
    render :edit
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
    params.require(:product).permit(:title, :meta_title, :categories, :price, :discount, :content, :quantity, images: [], category_ids: [],)
  end

  def authorize_admin!
    authorize current_user
  end
end
