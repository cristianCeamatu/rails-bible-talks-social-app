class ApplicationController < ActionController::Base
  def logged_in?
    !session[:username].nil?
  end

  def current_user
    User.find_by_username(session[:username]) if session[:username]
  end

  helper_method :logged_in?, :current_user
end
