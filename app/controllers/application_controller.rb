class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern

  include Pundit

  before_action :set_current_user   # ← THIS IS MISSING

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id])
  end

  def user_not_authorized
    flash[:alert] = "You are not allowed to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def pundit_user
    Current.user
  end
end
