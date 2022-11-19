class Admin::Users::DestroyService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    user&.destroy ? [true, 'User was successfully destroy.'] : [false, 'User was failure destroy.']
  end

  private

  attr_accessor :user
end
