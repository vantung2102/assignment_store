class Admin::ProductsController < Admin::BaseController
  # before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authorize_admin!, only: %i[ create update destroy ]

  def index
      products = Category.all

      @data = {
          products: products
      }
  end

  def show;end

  def new
      @category = Category.new
  end

  def create
    create, message = Admin::Categories::CreateService.call(category_params)

    status = create ? :success : :danger
    flash[status] = message
    redirect_to admin_categories_path
  end

  def edit;end

  def update
    update, message = Admin::Categories::UpdateService.call(@category, category_params)

    status = update ? :success : :danger
    flash[status] = message
    redirect_to edit_admin_category_url(@category)
  end

  def destroy
    destroy, message = Admin::Categories::DestroyService.call(@category)

    status = destroy ? :success : :danger
    flash[status] = message
    redirect_to admin_categories_path
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title, :meta_title, :content, :category_id)
    end

    def authorize_admin!
      authorize @user
    end
end