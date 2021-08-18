class LocationPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    scope.exists?(id: record.id)
  end

  def update?
    scope.exists?(id: record.id)
  end

  def destroy?
    scope.exists?(id: record.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none if user.blank?

      scope.where(buyer_id: user.id)
    end
  end
end
