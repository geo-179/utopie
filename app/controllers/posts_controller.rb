class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = policy_scope(Post)

    if params[:category].present?
      @posts = @posts.where(category: params[:category])
    end

    if params[:keyword].present?
      @posts = @posts.where("title ILIKE ?", "%#{params[:keyword]}%")
    end

  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)
    authorize @comment
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to user_path(current_user), data: { turbo_method: :delete, turbo_confirm: "Are you sure?" }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, photos: [])
  end
end
