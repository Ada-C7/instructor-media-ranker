class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])

    if user.nil?
      user = User.create_from_omniauth(auth_hash)

      if user.nil?
        flash.now[:status] = :failure
        flash.now[:result_text] = "Could not log in"
        redirect_to root_path
      end
    end

    session[:user_id] = user.id
    flash[:status] = :success
    flash[:result_text] = "Successfully logged in as #{user.email}!"
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
