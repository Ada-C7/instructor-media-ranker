class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  def self.find_user
    @user = User.find_by(id: session[:user_id])
  end
end
