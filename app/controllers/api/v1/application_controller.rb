class Api::V1::ApplicationController < ActionController::API
    # API controllers should NOT use CSRF or session cookies
    include Pundit::Authorization
  
    before_action :authenticate_api_user!
  
    private
  
    def authenticate_api_user!
      header = request.headers['Authorization']
      token = header.split(' ').last rescue nil
  
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
  
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    end
  
    def current_user
      @current_user
    end
  end
  