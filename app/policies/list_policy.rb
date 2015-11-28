class ListPolicy < ApplicationPolicy
  def update?
    destroy?
  end

  def edit?
    update?
  end
end
