class UsersController < ApplicationController
  before_action :require_login, except: [:login]

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
      oauth_uid: auth_hash["uid"])
    if user.nil?
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Successfully logged in as existing user #{user.username}"
        redirect_to root_path
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Could not log in"
        flash.now[:messages] = user.errors.messages
        redirect_to "/auth/github", status: :bad_request
        #go back to log in page?
        return
        end
      end
    else
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Successfully logged in as returning #{user.username}"
      redirect_to root_path
    end

    def logout
      session[:user_id] = nil
      flash[:status] = :success
      flash[:result_text] = "Successfully logged out"
      redirect_to root_path
    end

end
