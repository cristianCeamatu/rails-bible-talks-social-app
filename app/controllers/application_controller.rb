class ApplicationController < ActionController::Base
  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.includes(:followers, :followed_users).find(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?, :current_user
end
