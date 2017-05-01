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
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    find_user()
    if @login_user.nil?
      flash[:message] = "You must logged in to see that page"
      redirect_to root_path#, status: :unauthorized
    end
  end

  def check_owner
    find_user()
    if @work.user != nil
      if @work.user.username != @login_user.username
        flash[:message] = "You must be owner of a work to edit/delete it"
        redirect_to work_path(@work.id)
      end
    elsif @work.user == nil
      flash[:message] = "You must be owner of a work to edit/delete it"
      redirect_to work_path(@work.id)
    end
  end


end
