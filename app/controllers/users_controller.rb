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

    user = User.from_github(auth_hash)

    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, new user #{user.username}"
    else
      flash[:failure] = "Could not log in"
      user.errors.messages.each do |field, problem|
        flash[:field] = problem.join(', ')
      end
    end

    redirect_to root_path


  end
end
