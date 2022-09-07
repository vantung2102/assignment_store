class Admin::Users::UpdateService < ApplicationService
    def initialize(user, user_params)
        @user = user
        @user_params = user_params
    end

    def call
        update = user.update(user_params.except(:roles))
        message = update ? "User was successfully updated." : "User was failure updated."
        [update, message]  
    end

    private

    attr_accessor :user, :user_params
end