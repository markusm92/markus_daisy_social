class PostPolicy < ApplicationPolicy
  # 👇 Added this Scope class so policy_scope(Post) works
  class Scope < Scope
    def resolve
      # Everyone can see all posts
      scope.all
    end
  end

  def show?
    # Allow everyone to view posts
    true
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
