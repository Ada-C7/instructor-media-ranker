class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :find_user
  private

  def find_user
    unless session[:user_id].nil?
      @current_user = User.find_by(id: session[:user_id])  #always use find_by
    end
  end

  def require_login
    find_user
    if @current_user.nil?
  
      flash[:result_text] = "You must be logged in to see that page"
      #In a before_action filter, this will prevent the action from running at all
      redirect_to root_path
    end
  end
end
