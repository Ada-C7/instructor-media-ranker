class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  def login
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(
      oauth_provider: params[:provider],
      oauth_uid: auth_hash["uid"]
    )

    if user.nil?
      # build a new user
      user = User.from_github(auth_hash)

      if user.save
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Welcome, new user #{user.username}"
        redirect_to root_path
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Could not log in"
        flash.now[:messages] = user.errors.messages
        # flash[:failure] = "Could not log in"
        # user.errors.messages.each do |field, problem|
        #   flash[:field] = problem.join(', ')
        # end
        # Go back to the login page? DOES THIS WORK?
        redirect_to "/auth/github"
      end
    else
      # log in existing user
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Welcome back, user #{user.username}"
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
