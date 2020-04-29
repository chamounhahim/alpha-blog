class ApplicationController < ActionController::Base
    before_action :set_locale

  # If we have a current_user already then return current_user else we find the current user in the db
  # Also makes it available to use in the views (like a helper)
  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]   
  end

  #Turns current_user into a boolean to check if there's a current_user 
  # Also makes it available to use in the views (like a helper)
  helper_method :logged_in?       
  def logged_in?
    !!current_user
  end


private
def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end
end
