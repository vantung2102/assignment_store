class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit::Authorization
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :switch_locale

  # def switch_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  # def default_url_options
  #   { locale: I18n.locale }
  # end

  protected

  def authenticate_user
    redirect_to new_user_registration_url unless user_signed_in?
  end

  def configure_permitted_parameters
    added_attrs = %i[name email phone gender password password_confirmation remember_me role]
    update_attrs = %i[password password_confirmation current_password]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def is_admin?
    current_user.has_role? :admin
  end

  def after_sign_in_path_for(resource)
    if is_admin?
      stored_location_for(resource) || admin_path
    else
      previous_path = session[:previous_url]
      session[:previous_url] = nil
      previous_path || root_path
    end
  end
end
