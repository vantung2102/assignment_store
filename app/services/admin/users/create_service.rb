class Admin::Users::CreateService < ApplicationService
    def initialize(user_params)
        @user_params = user_params
        @role = user_params[:roles]
    end

    def call
        @user = User.new(user_params.except(:roles))
        create = @user.save

        if create
            add_role(@user)
        end

        [create, @user]  
    end

    private

    attr_accessor :user_params, :role

    def add_role(user)
        role == 'admin' ? user.add_role(:admin) : user.add_role(:user)
    end

end