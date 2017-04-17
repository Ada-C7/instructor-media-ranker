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
  end
end
