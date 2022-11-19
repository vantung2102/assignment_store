class Admin::VouchersController < Admin::BaseController
  before_action :set_voucher, only: %i[show edit update destroy]
  before_action :authorize_admin!

  def index
    @pagy, @vouchers = pagy(Voucher.all, items: 10)
  end

  def show; end

  def new
    @voucher = Voucher.new
  end

  def create
    create, @voucher, message = Admin::Vouchers::CreateService.call(voucher_params)

    if create
      flash[:success] = message
      redirect_to admin_vouchers_url
    else
      flash[:danger] = message
      render :new
    end
  end

  def edit; end

  def update
    update, message = Admin::Vouchers::UpdateService.call(@voucher, voucher_params)

    status = update ? :success : :danger
    flash[status] = message
    render :edit
  end

  def destroy
    destroy, message = Admin::Vouchers::DestroyService.call(@brand)

    status = destroy ? :success : :danger
    flash[status] = message
    redirect_to admin_vouchers_url
  end

  private

  def set_voucher
    @voucher = Voucher.find(params[:id])
  end

  def voucher_params
    params.require(:voucher).permit(
      :code, :cost, :name,
      :max_user,
      :discount_mount,
      :apply_amount,
      :type_voucher,
      :status,
      :start_time, :end_time,
      :description
    )
  end
end
