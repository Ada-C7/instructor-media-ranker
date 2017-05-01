class SessionsController < ApplicationController


  def auth_callback
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(oauth_provider: params[:provider],
    oauth_uid: auth_hash["uid"])


    if user.nil?
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
      else
        flash[:message] = "Could not log in"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end
    else
      session[:user_id] = user.id
      flash[:message] = "successfully logged in as a returning user #{user.username}"
      raise
    end
    redirect_to root_path
  end

  def index
    @user = User.find(session[:user_id])
  end

  def logout
    session[:user_id] = nil
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
