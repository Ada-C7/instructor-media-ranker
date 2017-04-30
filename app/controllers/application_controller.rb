class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def find_user
    unless session[:user_id].nil?
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    find_user
    if @login_user.nil?

      flash[:messages] = "You must be logged in to view page."

      redirect_to root_path
    end
  end

  def can_create_work
    #Admittedly unnecessary, but I kept it because I think it enhances code
    # readability in the works controller.
    find_user

    if @login_user.id == nil

      flash[:result_text] = "Can not create new work unless you're registered."

      redirect_to root_path
    end
  end

  def can_edit_work
    find_user

    work = Work.find_by(id: params[:id])
    unless @login_user.id == work.user_id
      flash[:messages] = "Only the creator is allowed to edit a work."
      redirect_to work_path(work)
    end
  end

  def can_delete_work
    find_user

    work = Work.find_by(id: params[:id])
    unless @login_user.id == work.user_id
      flash[:messages] = "Only the creator is allowed to delete a work."
      redirect_to work_path(work)
    end
  end
end
