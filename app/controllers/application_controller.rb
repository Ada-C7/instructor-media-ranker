class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  before_action :require_login
helper_method :current_user

  def require_login
    #See if we have a logged-in user (probably using session)
    if !session[:user_id]
      #if not logged-in
      #Show message about not being logged-in and send to root route
      flash[:status] = :failure
      flash[:result_text] = "You must be logged in to view this page"
      redirect_to root_path
    end
    #Let it be if there is  someone logged-in
  end

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  def current_user
    # MEMOIZE: storing something so yo don't have to retrieve it all the time
    @logged_in_user ||= User.find(session[:user_id]) if session[:user_id]
  end


private
  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
