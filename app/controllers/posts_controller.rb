class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts
  def index
    # Show all posts (global feed)
    @posts = policy_scope(Post)
             .includes(:user, :likes, :comments, images_attachments: :blob)
             .order(created_at: :desc)
  end

  # GET /posts/1
  def show
    # Any user can view another user's post
    authorize @post
  end

  # GET /posts/new
  def new
    @post = Current.user.posts.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts
  def create
    @post = Current.user.posts.new(post_params)
    authorize @post

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    authorize @post

    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    authorize @post
    @post.destroy!

    redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:belongs_to, :caption, :body, images: [])
  end
end
