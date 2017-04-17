class SessionsController < ApplicationController

skip_before_action :check_login, only: [:create]

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    if user.nil?
      user = User.create_from_github(auth_hash)
      if user.nil?
        flash[:error] = "Unable to log you in."
        redirect_to root_path
      end
    end
    session[:user_id] = user.id
    session[:username] = user.name
    flash[:success] = "Logged in as #{session[:username]}"
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
