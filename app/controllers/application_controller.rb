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
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    lookup_user
    if @current_user.nil?
      flash[:result_text] = "You need to be logged to see that page"
      redirect_to root_path
    end
  end
end
