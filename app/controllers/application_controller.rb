class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, :find_user

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  def require_login
    if !session[:user_id]
      flash[:status] = :failure
      flash[:result_text] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end

  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
