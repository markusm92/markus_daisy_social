class LikesController < ApplicationController
    before_action :set_post
    before_action :require_user_logged_in  # optional: ensures only logged-in users can like
  
    # POST /posts/:post_id/likes
    def create
      # Prevent duplicate likes using find_or_create_by
      @like = @post.likes.find_or_create_by(user: Current.user)
      redirect_to post_path(@post)
    end
  
    # DELETE /posts/:post_id/likes/:id
    def destroy
      @like = @post.likes.find_by(user: Current.user)
      @like&.destroy
      redirect_to post_path(@post)
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def require_user_logged_in
      unless Current.user
        redirect_to root_path, alert: "You must be logged in to like a post."
      end
    end
  end
  