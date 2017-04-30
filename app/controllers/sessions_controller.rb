class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(uid: auth_hash[:uid], provider: 'github')
      if user.nil?
        user = User.create_from_github(auth_hash)
      else
        flash[:success] = "Logged in successfully"
        redirect_to :root
      end

      session[:user_id] = user.id
    else
      flash[:error] = "Login failed"
      redirect_to :root
    end

  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
