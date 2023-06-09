class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.includes(:likes, comments: { user: { photo_attachment: :blob }}, user: {photo_attachment: :blob}, photos_attachments: :blob).all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def can_like?
    result = true

    record.likes.each do |like|
      result = false if like.user == user
    end

    return result
  end

  def can_bookmark?
    result = true

    record.bookmarks.each do |bookmark|
      result = false if bookmark.user == user
    end

    return result
  end
end
