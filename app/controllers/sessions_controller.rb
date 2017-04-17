class SessionsController < ApplicationController

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end


  def auth_callback
    auth_hash = request.env['omniauth.auth']

    #Login existing user
    user = User.find_by(oauth_provider:params[:provider],
    oauth_uid: auth_hash["uid"])
    if user.nil?
      #Build a new user
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:message] = "Successfully logged in a s user #{user.username}"
        redirect_to root_path
      else
        flash[:message]= "could not log in"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join (',')
        end
      end
    else
      #if we find a user we log them in! Welcome them back!
      session[:user_id] = user.id
      flash[:messsage]= "Welcome back, #{user.username}!"
      redirect_to root_path

    end
  end
end
