class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :lookup_user
  # before_action :find_user

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def lookup_user
    unless session[:user_id].nil?
      @current_user= User.find_by(id: session[:user_id])
    end
  end

  # def find_user
  #   if session[:user_id]
  #     @login_user = User.find_by(id: session[:user_id])
  #   end
  # end
end
