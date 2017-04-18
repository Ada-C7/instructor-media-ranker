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

    user = User.find_by(oauth_provider: params[:provider], oauth_id: auth_hash["uid"])

    if user.nil?
      user = User.from_github(auth_hash)
      if user.save
        session[:user_id] = user.id
        flash[:message] = "Logged in as new user."
      else
        flash[:message] = "Login Unsuccessful."
        user.error.message.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end

    else
      session[:user_id] = user.id
      flash[:message] = "Logged in as #{user.username}."
    end
    redirect_to root_path
  end
end
