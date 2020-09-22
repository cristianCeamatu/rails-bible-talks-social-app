class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by_username(params[:username])

    if @user
      session[:username] = @user.username
      redirect_to root_path, notice: "User #{@user.fullname} was successfully logged in."
    else
      flash.now.notice = 'Login failed, user not found. Please try again or create a new user.'
      render :new
    end
  end

  def destroy
    session.delete(:username)
    flash.notice = 'Succesfully logged out.'
    redirect_to sign_in_path
  end
end
