class FollowingsController < ApplicationController
  def create
    @following = Following.new(follower_id: current_user.id, followed_id: params[:followed_id])

    if @following.save
      redirect_to root_path, notice: 'Successfully followed'
    else
      redirect_to root_path, notice: 'Could not create following, most probably it already exists.'
    end
  end

  def destroy
    @following = Following.find_by(followed_id: params[:followed_id])

    @following.destroy
    redirect_to root_path, notice: 'Succesfully unfollowed!'
  end
end
