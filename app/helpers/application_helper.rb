module ApplicationHelper
  def logged_in?
    !session[:username].nil?
  end

  def current_user
    User.find_by_username(session[:username])
  end
end
