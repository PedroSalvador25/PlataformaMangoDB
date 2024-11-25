class PlantPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
    #user.administrator?
  end

  def update?
    true
    #user.administrator?
  end

  def destroy?
    true
    #user.administrator?
  end

  class Scope < ApplicationPolicy::Scope
    #def resolve
    #  if user.administrator?
    #    scope.all
    #  end
    #end
  end
end
