class SessionsController < ApplicationController

skip_before_action :require_login , only:[:create]

  def login_form
  end

  def index
    @user = User.find(session[:user_id]) # < recalls the value set in a previous request
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

    if user.nil?
      user = User.build_from_github(auth_hash)
      if user.nil?
        flash[:error] = "Could not log in."
        redirect_to root_path
      end
    else# having this end here means that the login will always set the session user id to the user id regardless of whether the user is in the database
      session[:user_id] = user.id # this is the identifier from our user database
      flash[:success] = "Logged in successfully"
      redirect_to root_path
    end
  end

  # def login
  #   username = params[:username]
  #   if username and user = User.find_by(username: username)
  #     session[:user_id] = user.id
  #     flash[:status] = :success
  #     flash[:result_text] = "Successfully logged in as existing user #{user.username}"
  #   else
  #     user = User.new(username: username)
  #     if user.save
  #       session[:user_id] = user.id
  #       flash[:status] = :success
  #       flash[:result_text] = "Successfully created new user #{user.username} with ID #{user.id}"
  #     else
  #       flash.now[:status] = :failure
  #       flash.now[:result_text] = "Could not log in"
  #       flash.now[:messages] = user.errors.messages
  #       render "login_form", status: :bad_request
  #       return
  #     end
  #   end
  #   redirect_to root_path
  # end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

end
