class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :authorize_admin!, only: %i[ update destroy ]

    def index
        users = User.all

        @data = {
            users: users
        }
    end

    def show;end

    def new
        @user = User.new
    end

    def create
        create, message = Admin::Users::CreateService.call(user_params, role_param)

        status = create ? :success : :danger
        flash[status] = message
        redirect_to admin_users_path
    end

    def edit;end

    def update
        update, message = Admin::Users::UpdateService.call(@user, user_params)

        status = update ? :success : :danger
        flash[status] = message
        redirect_to edit_admin_user_url(@user)
    end

    def destroy
        destroy, message = Admin::Users::DestroyService.call(@user)

        status = destroy ? :success : :danger
        flash[status] = message
        redirect_to admin_users_url
    end

    private
        def set_user
            @user = User.find(params[:id])
        end

        def user_params
            params.require(:user).permit(:name, :phone, :gender, :address, :email, :password, :password_confirmation)
        end

        def role_param
            params.require(:user).permit(:roles)
        end

        def authorize_admin!
            authorize @user
        end
end