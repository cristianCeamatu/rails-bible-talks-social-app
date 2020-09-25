class FollowingsController < ApplicationController
  def create
    @following = Following.find_or_initialize_by(follower_id: current_user.id, followed_id: params[:followed_id])

    if @following.save
      redirect_to request.referer, notice: "Successfully followed `#{@following.followed.fullname}`"
    else
      redirect_to request.referer, notice: 'Could not create following, most probably it already exists.'
    end
  end

  def destroy
    @following = Following.find_by(followed_id: params[:followed_id])

    if @following.nil?
      redirect_to request.referer, notice: 'Could not delete following, most probably it does not exist exist.'
    else
      @following.destroy
      redirect_to request.referer, notice: "Succesfully unfollowed `#{@following.followed.fullname}`"
    end
  end
end
