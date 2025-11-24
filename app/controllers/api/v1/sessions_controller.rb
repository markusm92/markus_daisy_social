class Api::V1::SessionsController < Api::V1::ApplicationController
    skip_before_action :authenticate_api_user!, only: :create
  
    def create
      user = User.authenticate_by(email_address: params[:email], password: params[:password])
  
      if user
        token = JsonWebToken.encode(user_id: user.id)
        render json: { token: token, user: user.slice(:id, :email_address) }
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  end
  