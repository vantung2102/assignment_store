class Admin::Users::CreateService < ApplicationService
    ROLE = { user: 1, admin: 2 }.freeze

    def initialize(user_params, role)
        @user_params = user_params
        @role = role[:roles].to_i
    end

    def call
        user = User.new(user_params)
        create = user.save
        message =   if create && role == ROLE[:admin]
                        user.add_role :admin
                        "User was successfully created with role admin."
                    elsif create && role == ROLE[:user]
                        user.add_role :user
                        "User was successfully created with role user."
                    else
                        "User was failure created ."
                    end
        [create, message]  
    end

    private

    attr_accessor :user_params, :role
end