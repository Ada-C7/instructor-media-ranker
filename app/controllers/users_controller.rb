class UsersController < ApplicationController
  before_action :block_if_not_logged_in

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end
end
