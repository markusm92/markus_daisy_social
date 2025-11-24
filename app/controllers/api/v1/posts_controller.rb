class Api::V1::PostsController < Api::V1::ApplicationController
    def index
      posts = Post.includes(:user, :likes, :comments).order(created_at: :desc)
  
      render json: posts.as_json(
        include: {
          user: { only: [:id, :email_address] },
          comments: {
            include: { user: { only: [:id, :email_address] } }
          }
        },
        methods: [:likes_count]
      )
    end
  
    def create
      post = current_user.posts.build(post_params)
  
      if post.save
        render json: post, status: :created
      else
        render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def post_params
      params.permit(:caption, :body)
    end
  end
  