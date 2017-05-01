class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login
    auth_hash = request.env['omniauth.auth']

    # Attempt to find these credentials in our DB
    user = User.find_by(oauth_provider: params[:provider],
    oauth_uid: auth_hash["uid"])

    if user.nil?
      # Don't know this user - build a new one
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:result_text] = "Successfully logged in as new user #{user.username}"
      else
        flash[:result_text] = "Could not log in"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end

    else
      # Welcome back!
      session[:user_id] = user.id
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
