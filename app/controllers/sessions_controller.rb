class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def login_form; end

  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

    if user.nil?
      user = User.create_from_github(auth_hash)
      if user.nil?
        flash[:status] = :error
        flash[:result_text] = "Could not log in"
        redirect_to root_path
      end
    end

    session[:user_id] = user.id
    flash[:status] = :success
    flash[:result_text] = "Logged in successfully!"
    redirect_to root_path

  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
