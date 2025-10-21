class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern

  # Pundit setup for authorization
  include Pundit

  # Rescue from unauthorized access
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not allowed to perform this action."
    redirect_to(request.referrer || root_path)
  end

  # Add this for Pundit
  def pundit_user
    Current.user
  end
end
