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
end
