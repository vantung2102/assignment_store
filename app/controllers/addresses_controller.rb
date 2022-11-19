class AddressesController < ApplicationController
  before_action :authenticate_user
  before_action :set_address, only: %i[update edit destroy]
  rescue_from Pundit::NotAuthorizedError, with: :address_not_authorized

  def index
    @addresses = current_user.addresses
    authorize @addresses
  end

  def show_address
    @addresses = current_user.addresses
    authorize @addresses

    html = render_to_string partial: 'addresses/shared/address'
    render json: { status: 200, message: 'successfully', html: html }
  end

  def new
    @address = Address.new
  end

  def create
    create, @address, message = Client::Address::CreateService.call(address_params, current_user)

    if create
      flash[:success] = message
      redirect_to user_addresses_path
    else
      flash[:danger] = message
      render :new
    end
  end

  def edit; end

  def update
    authorize @address
    update, message = Client::Address::UpdateService.call(@address, address_params)

    if update
      flash[:success] = message
      redirect_to user_addresses_path
    else
      flash[:danger] = message
      render :edit
    end
  end

  def destroy
    authorize @address
    if @address&.destroy
      render json: { status: 200, message: 'Successfully' }
    else
      render json: { status: 500, message: 'error' }
    end
  end

  def change_address
    change = Client::Address::ChangeService.call(change_address_params, current_user)
    authorize current_user.addresses

    if change
      render json: { status: 200, message: 'Successfully' }
    else
      render json: { status: 500, message: 'error' }
    end
  end

  private

  def set_address
    @address = current_user.addresses.find_by(id: params[:id])
  end

  def address_params
    params.require(:address).permit(
      :fullname,
      :phone_number,
      :province_id,
      :province,
      :district_id,
      :district,
      :ward_id,
      :ward,
      :addressDetail
    )
  end

  def change_address_params
    params.require(:change_address)
  end
end
