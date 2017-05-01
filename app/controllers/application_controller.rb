class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user
  before_action :require_login, only: [:current_user]
  helper_method :current_user

  def require_login
    if !session[:user_id]
      flash[:status] = :failure
      flash[:result_text] =
      "You must be logged in as a user to view this page"
      redirect_to root_path
    end
  end

  def current_user
    @logged_in_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

private
  def find_user
    unless session[:user_id].nil?
      @logged_in_user = User.find_by(id: session[:user_id])
    end
  end
end
