module ApplicationHelper
  def user_image(user)
    if user.photo.attached?
      user.photo
    else
      gravatar_image_url(user.username)
    end
  end

  def user_cover_image(user)
    if user.cover_image.attached?
      user.cover_image
    else
      'placeholder.jpg'
    end
  end

  def flash_errors(flash)
    flash.each do |key, value|
      render 'flashes', key: key, value: value
    end
  end

  def mobile_right_button(user, users)
    if @user.nil?
      render 'users/mobile/who_to_follow', users: users
    else
      render 'users/mobile/show_user', user: user
    end
  end

  def form_errors(user)
    render 'users/form_errors', user: user if user.errors.any?
  end
end
