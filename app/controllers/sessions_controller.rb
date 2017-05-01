class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    raise
  end

  def login
    auth_hash = request.env['omniauth.auth']

    #log in a returning user
    user = User.find_by(oauth_provider: params[:provider], oauth_uid: auth_hash["uid"])

    if user.nil?
      #build a new user
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Successfully logged in as a new user #{user.username}"


      else
        flash[:message] = "Could not log in"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end

    else
      #welcome back
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Welcome back, #{user.username}"
    end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
