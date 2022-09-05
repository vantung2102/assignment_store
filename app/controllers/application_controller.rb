class ApplicationController < ActionController::Base
    include Pundit::Authorization
    
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        added_attrs = [:name, :email, :phone, :gender, :password, :password_confirmation, :remember_me, :role]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
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
