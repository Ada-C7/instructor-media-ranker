class SessionsController < ApplicationController


  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

      if user.nil?
        user = User.build_from_github(auth_hash)
        if user.nil?
          flash[:error] = "Could not log in"
          redirect_to root_path
        end
      else
        session[:user_id] = user.id
        flash[:success] = "Logged in successfully"
        redirect_to root_path
      end
    end
  end

  def logout
    session.delete(:user_id)
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
  
end
