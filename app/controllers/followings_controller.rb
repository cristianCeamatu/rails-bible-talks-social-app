class FollowingsController < ApplicationController
  def create
    @followed = User.find(params[:followed_id])
    @following = current_user.followings.new(followed_id: params[:followed_id])

    if @following.save
      redirect_to request.referer, notice: "Successfully followed #{@followed.fullname}"
    else
      render template: 'opinions/index', notice: 'Could not create following, most probably it already exists.'
    end
  end

  def destroy
    @following = Following.find_by(followed_id: params[:followed_id])

    redirect_to request.referer, notice: 'Succesfully unfollowed!' if @following.destroy!
  end
end
