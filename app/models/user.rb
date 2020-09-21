class User < ApplicationRecord
  has_many :opinions, dependent: :destroy, foreign_key: 'author_id'
  has_many :followings, dependent: :destroy, foreign_key: 'follower_id'
  has_many :followers, class_name: 'Following', dependent: :destroy, foreign_key: 'followed_id'

  validates :username, presence: true, length: { minimum: 2, maximum: 20 }
  validates_uniqueness_of :username, on: :create, message: 'already taken, please choose another one.'
  validates :fullname, presence: true, length: { minimum: 2, maximum: 20 }
end
