class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.posts.count > 0
      @banner = @user.posts.shuffle().last.photos.shuffle().last
    else
      @banner = Post.all.shuffle().last.photos.shuffle().last
    end
    posts = Post.where(user_id: params[:id]).group_by_month(:created_at, format: "%b %Y", reverse: true).count
    bookmarks = Bookmark.where(user_id: params[:id]).group_by_month(:created_at, format: "%b %Y", reverse: true).count
    comments = Comment.where(user_id: params[:id]).group_by_month(:created_at, format: "%b %Y", reverse: true).count
    combined = posts.merge(bookmarks, comments)
    @contributions = {}
    combined.each_key do |key|
      @contributions[key] = [posts[key], bookmarks[key], comments[key]]
    end


    # @contributions = pb_hash.merge(comments) do |key, pb, comment|
    #   comment = 0 if comment.nil?
    #   pb << comment
    # end
    authorize @user
  end
end
