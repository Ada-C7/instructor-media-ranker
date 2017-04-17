class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  def auth_callback
    auth_hash = request.env['omniauth.auth']

    # Attempt to find these credentials in out DB
    user = User.find_by(oauth_provider: params[:provider], oauth_uid: auth_hash["uid"])

    if user.nil?
      # Don't know this user - build a new one
      # using the from_github method we wrote in the user model
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:message] = "Succesfully logged in as new user #{user.username}"
      else
        flash[:message] = "Could not log in"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end

    else
      # Welcome back!
      session[:user_id] = user.id
      flash[:message] = "Welcome back, #{user.username}"
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
