class User < ApplicationRecord
  has_many :opinions, dependent: :destroy, foreign_key: 'author_id'
  has_many :followings, dependent: :destroy, foreign_key: 'follower_id'
  has_many :inverse_followings, dependent: :destroy, class_name: 'Following', foreign_key: 'followed_id'
  has_many :followed_users, through: :followings, class_name: 'User', source: 'followed'
  has_many :followers, through: :inverse_followings, class_name: 'User', source: 'follower'
  has_one_attached :photo
  has_one_attached :cover_image

  validates :username, presence: true, length: { minimum: 2, maximum: 20 }
  validates_uniqueness_of :username, on: :create
  validates :fullname, presence: true, length: { minimum: 2, maximum: 40 }

  scope :all_except, ->(user) { where.not(username: user.username) }

  def follows?(user)
    followed_users.include?(user)
  end
end
