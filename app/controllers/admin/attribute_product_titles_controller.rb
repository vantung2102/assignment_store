class Admin::AttributeProductTitlesController < Admin::BaseController
  before_action :set_attributes_product, only: %i[ show edit update destroy ]
  before_action :authorize_admin!, only: %i[ update destroy ]

  def index
    @pagy, @attributes_products = pagy(AttributeProductTitle.all, items: 10)
  end

  def show;end

  def new
    @attribute_product = AttributeProductTitle.new
  end

  def create
    create, @attribute_product, message = Admin::AttributeProductTitles::CreateService.call(attribute_product_title_params)

    if create
      flash[:success] = message
      redirect_to admin_attribute_product_titles_url
    else
      flash[:danger] = message
      render :new
    end
  end

  def edit;end

  def update
    update, message = Admin::attributes_products::UpdateService.call(@attributes_product, attribute_product_title_params)

    status = update ? :success : :danger
    flash[status] = message
    render :edit
  end

  def destroy
    destroy, message = Admin::attributes_products::DestroyService.call(@attributes_product)

    status = destroy ? :success : :danger
    flash[status] = message
    redirect_to admin_attributes_products_url
  end

  private

  def set_attributes_product
    @attributes_product = AttributeProductTitles.find(params[:id])
  end

  def attribute_product_title_params
    params.require(:attribute_product_title).permit(:title)
  end

  def authorize_admin!
    authorize current_user
  end
end