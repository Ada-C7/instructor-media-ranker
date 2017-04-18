class SessionsController < ApplicationController

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end


  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(oauth_id: auth_hash[:"uid"], oauth_provider: params[:provider] ) #provider: "github" - provide from routes

    if user.nil? # if we cant find user in database
      # Build a new user:
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:message] = "Successfully logged in as NEW #{user.username}"
      else
        flash[:message] = "Could not log in as new user"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(", ")
        end
      end
    else # if we found a user in our database
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.username}"
    end
    redirect_to root_path
  end

end
