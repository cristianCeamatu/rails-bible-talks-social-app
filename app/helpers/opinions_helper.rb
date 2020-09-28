module OpinionsHelper
  def user_followers(user)
    if user.followers.any?
      render 'opinions/user_followed_by', user: user
    else
      render 'opinions/user_no_followers'
    end
  end
end
