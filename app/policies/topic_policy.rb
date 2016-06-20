class TopicPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    user.present? && (user.admin?)
  end

  def destroy?
    update?
  end
end
