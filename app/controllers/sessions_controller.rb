class SessionsController < ApplicationController
  def new; end

  def create
    raise omniauth_hash.to_yaml if omniauth_hash
    @user = omniauth_hash.nil? ? User.find_by_username(params[:username]) : User.from_omniauth(omniauth_hash)

    if @user
      session[:user_id] = @user.id
      redirect_to root_path, notice: "User #{@user.fullname} was successfully logged in."
    else
      flash.now.notice = 'Login failed, user not found. Please try again or create a new user.'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash.notice = 'Succesfully logged out.'
    redirect_to sign_in_path
  end

  private

  def omniauth_hash
    request.env['omniauth.auth']
  end
end
