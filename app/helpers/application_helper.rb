module ApplicationHelper
  def user_image(user, size = 40)
    if user.photo.attached?
      user.photo.variant(resize: "#{size}x#{size}!")
    else
      gravatar_image_url(user.username, size: size)
    end
  end

  def user_cover_image(user, width = 640, height = 480)
    if user.cover_image.attached?
      user.cover_image.variant(resize: "#{width}x#{height}!")
    else
      'placeholder.jpg'
    end
  end
end
