module UsersHelper
  def user_photo_preview(user)
    render 'users/photo_preview', user: user if user.photo.attached?
  end

  def user_cover_image_preview(user)
    render 'users/cover_image_preview', user: user if user.cover_image.attached?
  end
end
