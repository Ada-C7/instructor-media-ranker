class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :find_user

  def require_login
    # see if we have logged in user (probably using session)
    if !session[:user_id]
    # if not logged in:
    # show message about not being logged in and to the root route
      flash[:warning] = "You must be logged in to view thing page"
      redirect_to root_path
    end
    # let it be if there's someone logged in
  end

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

private
  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
