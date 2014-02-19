class ApplicationController < ActionController::Base
  protect_from_forgery

  
  private
	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	def require_user
    	unless current_user
      		flash[:notice] = "You must be logged in or Register to access this page"
      		redirect_to root_url
      		return false
    	end
	end

  helper_method :current_user
end
