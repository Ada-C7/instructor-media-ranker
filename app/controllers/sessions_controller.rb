class SessionsController < ApplicationController
  def login_form
  end

  def auth_callback
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(oauth_provider: params[:provider], oauth_uid: auth_hash['uid'])

    if user.nil?
      user = User.from_github(auth_hash)

      if user.save
        session[:user_id] = user.id
        flash[:message] = "Successfully logged in as user #{user.username}"
      else
        flash[:message] = "Could not log in"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end
    else
      session[:user_id] = user.id
      flash[:message] = "Welcome back, #{user.username}"
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
