class Admin::BrandsController < Admin::BaseController
  before_action :set_brand, only: %i[show edit update destroy]
  before_action :authorize_admin!

  def index
    @pagy, @brands = pagy(Brand.all, items: 10)
  end

  def show; end

  def new
    @brand = Brand.new
  end

  def create
    create, @brand, message = Admin::Brands::CreateService.call(brand_params)

    if create
      flash[:success] = message
      redirect_to admin_brands_url
    else
      flash[:danger] = message
      render :new
    end
  end

  def edit; end

  def update
    update, message = Admin::Brands::UpdateService.call(@brand, brand_params)

    status = update ? :success : :danger
    flash[status] = message
    render :edit
  end

  def destroy
    destroy, message = Admin::Brands::DestroyService.call(@brand)

    status = destroy ? :success : :danger
    flash[status] = message
    redirect_to admin_brands_url
  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:title)
  end
end
