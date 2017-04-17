class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  before_action :find_user

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  private
  def find_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    find_user
    if @current_user.nil?
      flash[:message] = "You must be logged in to see that page"
      redirect_to root_path
    end

  end
end
