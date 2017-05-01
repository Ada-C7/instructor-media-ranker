class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user
  before_action :require_login, except: [:root, :login]


  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

private
  def find_user
    # if session[:user_id]
    unless session[:user_id].nil?
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    find_user
    if @login_user.nil?
      flash[:status] = :failure
      flash[:result_text] = "You must be logged in to see that page"
      redirect_to root_path
    end
  end

  def require_ownership
    require_login
    @work = Work.find_by(id: params[:id])
    if @work.user_id != @login_user.id
      flash[:status] = :failure
      flash[:result_text] = "You must be the owner of the work to make that change"
      redirect_to work_path
    end
  end
end
