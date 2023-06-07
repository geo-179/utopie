class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    posts_hash = Post.where(user_id: params[:id]).group_by_month(:created_at, format: "%b %Y", reverse: true).count
    bookmarks_hash = Bookmark.where(user_id: params[:id]).group_by_month(:created_at, format: "%b %Y", reverse: true).count
    comments_hash = Comment.where(user_id: params[:id]).group_by_month(:created_at, format: "%b %Y", reverse: true).count
    pb_hash = posts_hash.merge(bookmarks_hash) { |key, post, bookmark| [post, bookmark] }
    @contributions = pb_hash.merge(comments_hash) do |key, pb, comment|
      if comment > 0
        pb << comment
      else
        pb << 0
      end
    end
    authorize @user
  end
end
