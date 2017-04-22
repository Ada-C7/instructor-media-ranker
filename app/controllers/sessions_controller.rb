class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]


  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

      if user.nil?
        user = User.build_from_github(auth_hash)
        if user.nil?
          flash[:status] = :failure
          flash[:result_text] = "Could not log in"
          redirect_to root_path
        end
      else
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Logged in successfully"
        redirect_to root_path
      end
    end
  end

  def logout
    session.delete(:user_id)
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

end
