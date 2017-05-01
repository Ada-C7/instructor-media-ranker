class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def login_form
  end

  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

    if user.nil?
      User.create_from_github(auth_hash)
      session[:user_id] = user.id
      session[:user_name] = user.name
    elsif user
      session[:user_id] = user.id
      session[:user_name] = user.name
      flash[:success] = "Logged in successfully"
      redirect_to root_path
    else
      flash[:error] = "Could not log in"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
