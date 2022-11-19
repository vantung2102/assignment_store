class Admin::BaseController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend
  layout 'admin'

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :authenticate_admin!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:danger] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def admin?
    current_user.has_role? :admin
  end

  def authenticate_admin!
    return if admin?

    redirect_to root_path
  end

  def authorize_admin!
    authorize current_user
  end
end
