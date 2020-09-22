class FollowingsController < ApplicationController
  def create
    @following = Following.new(follower_id: current_user.id, followed_id: params[:followed_id])

    if @following.save
      redirect_to request.referer, notice: 'Successfully followed'
    else
      render template: 'opinions/index', notice: 'Could not create following, most probably it already exists.'
    end
  end

  def destroy
    @following = Following.find_by(followed_id: params[:followed_id])

    @following.destroy
    redirect_to request.referer, notice: 'Succesfully unfollowed!'
  end
end
