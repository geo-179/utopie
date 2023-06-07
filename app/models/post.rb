class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :bookmarks
  has_many_attached :photos
  has_many :likes

  validates :title, :content, presence: true

  def my_like(current_user)
    return likes.find_by(user: current_user)
  end
end
