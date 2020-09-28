class Opinion < ApplicationRecord
  belongs_to :author, class_name: 'User'

  scope :all_followed_by, ->(user) { where(author_id: user.followed_users.pluck(:id)).or(where(author_id: user.id)) }

  validates :text, presence: true, length: { minimum: 2, maximum: 500 }

  def current_user_feeds(user)
    all_followed_by(user) + user.opinions
  end
end
