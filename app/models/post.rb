class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :bookmarks
  has_many_attached :photos
end
