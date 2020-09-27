class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :require_login, only: %i[show update edit]

  def show
    @user = User.includes(:opinions, :followed_users, :followers, cover_image_attachment: :blob, photo_attachment: :blob).find_by(user_id_param) # rubocop: disable Layout/LineLength
    @opinion = Opinion.new
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to request.referer, notice: 'Successfully updated!'
    else
      flash.now.notice = 'Please check the form errors.'
      render :edit
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to opinions_path, notice: 'User succesfully created and logged in.'
    else
      flash.now.notice = 'Please check the form errors.'
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

  def user_id_param
    params.permit(:id)
  end
end
