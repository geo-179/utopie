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
        @post, {
          rendered_string: render_to_string(partial: "like", locals: { post: @post }),
          button: render_to_string(partial: "like_button", locals: { post: @post }),
          liked_by: current_user.id
        }
        # brings the ID from the broadcasted user in order to use it to check which user needs their button updated
        # since sender also receives broadcast
      )
      head :ok
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @like
    @post = @like.post
    @like.destroy

    PostChannel.broadcast_to(
      @post, {
        rendered_string: render_to_string(partial: "like", locals: { post: @post }),
        button: render_to_string(partial: "like_button", locals: { post: @post }),
        liked_by: current_user.id
      }
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
