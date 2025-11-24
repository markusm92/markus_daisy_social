class PagesController < ApplicationController
  skip_before_action :require_authentication

  def home
    # Always fetch latest posts, whether logged in or not
    @posts = Post.includes(:user, :likes, :comments, images_attachments: :blob)
                 .order(created_at: :desc)
                 .limit(10)
  end
end
