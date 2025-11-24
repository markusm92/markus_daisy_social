class CommentsController < ApplicationController
    before_action :set_post
    before_action :require_user_logged_in  
    
    # POST /posts/:post_id/comments
    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = Current.user
  
      if @comment.save
        redirect_to post_path(@post), notice: "Comment added!"
      else
        redirect_to post_path(@post), alert: "Comment cannot be blank."
      end
    end
  
    # DELETE /posts/:post_id/comments/:id
    def destroy
      @comment = @post.comments.find(params[:id])
  
      if @comment.user == Current.user
        @comment.destroy
        redirect_to post_path(@post), notice: "Comment deleted."
      else
        redirect_to post_path(@post), alert: "You can only delete your own comments."
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  
    # Optional helper to restrict actions to logged-in users
    def require_user_logged_in
      unless Current.user
        redirect_to root_path, alert: "You must be logged in to perform this action."
      end
    end
  end
  