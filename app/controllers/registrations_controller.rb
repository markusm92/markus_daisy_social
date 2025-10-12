class RegistrationsController < ApplicationController
  skip_before_action :require_authentication
  def new
    @user = User.new
    @classes_for_body = "min-h-screen bg-gradient-to-b from-purple-400 to-pink-500"
  end

  def create
    if @user = User.create(user_params)
      start_new_session_for @user
      redirect_to root_path, notice: "User account was successfully created"
    else
      render :new
    end
  end

private

  def user_params
    params.expect(user: [:email_address, :password])
  end
end
