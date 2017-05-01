class SessionsController < ApplicationController

  def create

    auth_hash = request.env['omniauth.auth']
    user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])


    if user.nil?
      User.create_from_github(auth_hash)
    end

    session[:user_id] = user.id
    flash[:success] = "Logged in successfully"
    redirect_to root_path
  end

  def logout
    session.delete(:user_id)
    flash[:success] = "Logged out successfully"
    redirect_to root_path

  end
end
