class FollowingsController < ApplicationController
  def create
    @following = current_user.followings.find_or_initialize_by(following_params)

    if @following.save
      redirect_to request.referer, notice: "Successfully followed `#{@following.followed.fullname}`"
    else
      redirect_to request.referer, notice: 'Could not create following, most probably it already exists.'
    end
  end

  def destroy
    @following = current_user.followings.find_by(following_params)

    if @following.nil?
      redirect_to request.referer, notice: 'Could not delete following, most probably it does not exist exist.'
    else
      @following.destroy
      redirect_to request.referer, notice: "Succesfully unfollowed `#{@following.followed.fullname}`"
    end
  end

  private

  def following_params
    params.permit(:followed_id)
  end
end
