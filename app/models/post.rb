class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :bookmarks
  has_many_attached :photos

  validates :title, :content, presence: true
  validates :category, presence: true, inclusion: { in: ["3D Modeling", "2D Visual Art", "Music Tech"] }
end
