class AddressPolicy < ApplicationPolicy
  def index?
    record.map { |el| el.user_id == user.id }.include?(false) == false
  end

  def show_address?
    record.map { |el| el.user_id == user.id }.include?(false) == false
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end

  def change_address?
    record.map { |el| el.user_id == user.id }.include?(false) == false
  end
end
