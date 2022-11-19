class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :authorize_admin!

  def index
    @pagy, @categories = pagy(Category.all, items: 10)
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    create, @category, message = Admin::Categories::CreateService.call(category_params)

    if create
      flash[:success] = message
      redirect_to admin_categories_path
    else
      flash[:danger] = message
      render :new
    end
  end

  def edit; end

  def update
    update, message = Admin::Categories::UpdateService.call(@category, category_params)

    status = update ? :success : :danger
    flash[status] = message
    render :edit
  end

  def destroy
    destroy, message = Admin::Categories::DestroyService.call(@category)

    status = destroy ? :success : :danger
    flash[status] = message
    redirect_to admin_categories_path
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(
      :title,
      :meta_title,
      :content,
      :category_id
    )
  end
end
