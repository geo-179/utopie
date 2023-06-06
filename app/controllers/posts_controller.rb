class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all

    if params[:category].present?
      @posts = @posts.where(category: params[:category])
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
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
