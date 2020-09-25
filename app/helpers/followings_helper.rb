module FollowingsHelper
  def follow_action(user, form)
    if current_user.follows?(user)
      render 'followings/followed_button', form: form
    else
      render 'followings/follow_button', form: form
    end
  end

  def unfollow_action(user, form)
    if current_user.follows?(user)
      render 'followings/unfollow_button', form: form
    else
      render 'followings/unfollowed_button', form: form
    end
  end
end
