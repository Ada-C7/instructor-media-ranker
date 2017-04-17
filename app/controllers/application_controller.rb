class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :lookup_user

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

private
  def lookup_user
    unless session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    lookup_user
    if @user.nil?
      flash[:failure] = "You must login to view that page"
      redirect_to root_path
    end
  end
end
