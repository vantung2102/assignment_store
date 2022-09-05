class UserPolicy < ApplicationPolicy
    # before_action :authenticate_admin!
    def update?
        authenticate_admin
    end

    def destroy?
        authenticate_admin
    end

    def create?
        authenticate_admin
    end

    private

    def authenticate_admin
        user.has_role?(:admin)
    end
end