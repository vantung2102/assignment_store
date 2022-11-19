class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_user

  def edit; end

  def show_profile
    html = render_to_string partial: 'users/shared/profile'
    render json: { status: 200, message: 'successfully', html: html }
  end

  def update
    @user.update(user_params)
    render :edit
  end

  def password; end

  def show_password
    html = render_to_string partial: 'users/shared/change_password'
    render json: { status: 200, message: 'successfully', html: html }
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :name,
      :phone,
      :gender,
      :email,
      :password,
      :password_confirmation,
      :avatar
    )
  end
end
