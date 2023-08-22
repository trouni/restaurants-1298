class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope => contains the class that was passed in `policy_scope`, i.e. Restaurant
      # scope => Restaurant

      scope.all

      # # Example of advanced scope
      # if user.admin?
      #   scope.all
      # else
      #   scope.where(user: user)
      # end
    end
  end
  
  def show? # returns a boolean
    true
  end

  # # Already defined exactly in this way in the ApplicationPolicy
  # def new?
  #   create?
  # end

  def create?
    false
  end

  # def edit?
  #   # If you're allowed to update, you should be allowed to see the edit page
  #   update?
  # end
  
  def update?
    # Only the owner of the restaurant or admins can update
    user_is_owner? || user_is_admin?
  end
  
  def destroy?
    # Only the owner of the restaurant can destroy
    user_is_owner?
  end

  private

  def user_is_owner?
    # restaurant.user == current_user
    # In pundit:
    # user => current_user
    # record => restaurant (or whatever you pass next to the `authorize`)
    record.user == user
  end

  def user_is_admin?
    user.admin?
  end
end
