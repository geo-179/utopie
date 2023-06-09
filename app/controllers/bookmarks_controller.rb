class BookmarksController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_bookmark, only: [:destroy]

  def create
    @bookmark = Bookmark.new
    @bookmark.user = current_user
    @bookmark.post = @post
    authorize @bookmark

    if @bookmark.save
      redirect_back fallback_location: posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @bookmark
    current_path = request.path
    @bookmark.destroy
    redirect_back fallback_location: posts_path, data: { turbo_method: :delete, turbo_confirm: "Are you sure?" }
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
