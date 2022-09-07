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
        create, @user = Admin::Users::CreateService.call(user_params)

        if create
            flash[:success] = "User was successfully created."
            redirect_to admin_users_url
        else
            render :new
        end
    end

    def edit;end

    def update
        update, message = Admin::Users::UpdateService.call(@user, user_params)

        if update
            flash[:success] = "User was successfully updated."
            redirect_to admin_user_url(@user)
        else 
            render :edit
        end
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
        params.require(:user).permit(:name, :phone, :gender, :address, :email, :password, :password_confirmation, :avatar, :roles)
    end

    # def role_param
    #     params.require(:user).permit(:roles)
    # end

    def authorize_admin!
        authorize @user
    end
end