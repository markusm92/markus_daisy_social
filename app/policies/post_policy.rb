class PostPolicy < ApplicationPolicy
  def show?
    user_owns_post?
  end

  def edit?
    user_owns_post?
  end

  def update?
    user_owns_post?
  end

  def destroy?
    user_owns_post?
  end

  def create?
    user.present?
  end

  private

  def user_owns_post?
    user.present? && record.user_id == user.id
  end
end
