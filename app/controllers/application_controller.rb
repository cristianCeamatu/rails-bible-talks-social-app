class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def require_login
    return true if logged_in?

    redirect_to sign_in_path, notice: 'You must be logged in to access this section!'
  end

  def logged_in?
    current_user
  end

  def current_user
    @current_user ||= User.includes(:followers, :followed_users).find(session[:user_id]) if session[:user_id]
  end
end
