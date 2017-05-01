class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :current_user

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end

  def current_user
    # memoize = storing something so you don't have to retreive it all the time
    # if value is nil will run variable assignment and execute code
    # if it does have a value it won't execute code
    @logged_in_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    # see if we have a loged-in user (probably using session)
    if !session[:user_id]
      # if the user is not loged in, flash error message and redirect to login page
      flash[:warning] = "You must be logged in first"
      redirect_to root_path
    end
    # if the user is logged in leave
  end
end
