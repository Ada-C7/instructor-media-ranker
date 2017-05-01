class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :find_user

    def render_404
        # DPR: supposedly this will actually render a 404 page in production
        raise ActionController::RoutingError, 'Not Found'
    end

    private

    def find_user
        @login_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def require_login
        find_user
        if @login_user.nil?
            flash[:result_text] = 'You must be logged in to do that!'
            # In a before_action filter, this will prevent
            # the action from running at all
            redirect_to root_path
        end
    end
end
