class UserPolicy < ApplicationPolicy
	def index?
		authenticate_admin
	end

	def show?
		authenticate_admin
	end

	def new?
		authenticate_admin
	end

	def create?
		authenticate_admin
	end

	def edit?
		authenticate_admin
	end

	def update?
		authenticate_admin
	end

	def destroy?
		authenticate_admin
	end

	private

	def authenticate_admin
		user.has_role?(:admin)
	end
end