class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def new
    @user = User.new
  end

  def show
    @user = User.includes(:opinions, :followed_users, :followers, cover_image_attachment: :blob, photo_attachment: :blob).find(params[:id]) # rubocop: disable Layout/LineLength
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:username] = @user.username
      redirect_to opinions_path, notice: 'User succesfully created and logged in.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :fullname, :photo, :cover_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
