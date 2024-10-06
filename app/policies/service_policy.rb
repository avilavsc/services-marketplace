class ServicePolicy < ApplicationPolicy
  attr_reader :user, :service

  def initialize(user, service)
    @user = user
    @service = service
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user&.provider?
        scope.where(user: user)
      else
        scope.all
      end
    end
  end

  def show?
    true
  end

  def new
    user&.provider?
  end

  def create?
    user&.provider?
  end
end
