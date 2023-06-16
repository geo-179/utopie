class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, :content, presence: true
  validates :category, presence: true, inclusion: { in: ["3D Modeling", "2D Visual Art", "Music Tech"] }

  def my_like(current_user)
    return likes.find_by(user: current_user)
  end

  def my_bookmark(current_user)
    return bookmarks.find_by(user: current_user)
  end
end
