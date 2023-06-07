class LikesController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_like, only: [:destroy]

  def create
    @like = Like.new
    @like.post = @post
    @like.user = current_user
    authorize @like
    if @like.save
      PostChannel.broadcast_to(
        @post,
        render_to_string(partial: "like", locals: { likes: @post.likes.count })
      )
      head :ok
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @like
    @like.destroy

    PostChannel.broadcast_to(
      @post,
      {html: render_to_string(partial: "like", locals: { likes: @post.likes.count }), record: "like"}
    )
    head :ok
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
