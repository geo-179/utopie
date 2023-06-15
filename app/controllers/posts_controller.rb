require "rqrcode"

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :show
  after_action :verify_authorized, except: [:index, :show], unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  def index
    @posts = policy_scope(Post)
    @signed_in_user = current_user

    if params[:category].present?
      @posts = @posts.where(category: params[:category]).order("created_at DESC")
    end

    if params[:keyword].present?
      @posts = @posts.where("title ILIKE ?", "%#{params[:keyword]}%").order("created_at DESC")
    end

    @qr_codes = []
    @posts.each do |post|
      # url_for(post_path(post))

      url = url_for(controller: 'posts', action: 'show', id: post.id, only_path: false)
      puts "url #{url}"

      qr = RQRCode::QRCode.new(url)
      svg = qr.as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 11,
        standalone: true,
        use_path: true
      )
      @qr_codes << svg
    end
  end

  def show
    skip_policy_scope
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
      redirect_to posts_path(category: @post.category)
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
    redirect_to post_path(category: @post.category)
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
    params.require(:post).permit(:title, :content, :category, :link, photos: [])
  end
end
