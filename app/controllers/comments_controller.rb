class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @post = Post.find(params[:post_id])
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      PostChannel.broadcast_to(
        @post, {
          rendered_string: render_to_string(partial: "comment", locals: {comment: @comment})
        }
      )
      head :ok
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
