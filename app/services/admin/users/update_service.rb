class Admin::Users::UpdateService < ApplicationService
  def initialize(user, user_params)
    @user = user
    @user_params = user_params
  end

  def call
    update = user.update(user_params.except(:roles))

    message = if update
                change_role(user_params[:roles])
                'User was successfully updated.'
              else
                'User was failure updated.'
              end
    [update, message]
  end

  private

  attr_accessor :user, :user_params

  def change_role(role)
    if role == 'admin'
      user.remove_role(:user)
      user.add_role(:admin)
    else
      user.remove_role(:admin)
      user.add_role(:user)
    end
  end
end
