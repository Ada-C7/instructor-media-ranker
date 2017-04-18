class SessionsController < ApplicationController

  def login
    auth_hash = request.env['omniauth.auth']
    # raise  # this raise will raise an error and let you see what is in the auth_hash ☺ Don’t want this all the time
    user = User.find_by(oauth_provider: params[:provider],
                      oauth_uid: auth_hash["uid"])

    if user.nil?
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Welcome #{user.username} - you are logged in through Github"
      else
        flash[:failure] = "could not log in"
        flash[:messages] = user.errors.messages
      end
    else
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.username}"
    end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Logged Out"
    redirect_to root_path
  end
end
