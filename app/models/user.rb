class User < ApplicationRecord
  has_many :opinions, dependent: :destroy, foreign_key: 'author_id'
  has_many :followings, dependent: :destroy, foreign_key: 'follower_id'
  has_many :inverse_followings, dependent: :destroy, class_name: 'Following', foreign_key: 'followed_id'
  has_many :followed_users, through: :followings, class_name: 'User', source: 'followed'
  has_many :followers, through: :inverse_followings, class_name: 'User', source: 'follower'
  has_one_attached :photo
  has_one_attached :cover_image

  validates :username, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates_uniqueness_of :username, on: :create
  validates :fullname, presence: true, length: { minimum: 2, maximum: 30 }
  validates :photo, content_type: %i[png jpg jpeg],
                    size: { less_than: 3.megabytes, message: 'is not given between size. It whould be under 3mb.' }
  validates :cover_image, content_type: %i[png jpg jpeg],
                          size: { less_than: 4.megabytes,
                                  message: 'is not given between size. It should be under 4mb.' }

  scope :all_except, ->(user) { where.not(id: user) }
  scope :all_not_followed, ->(user) { User.all_except(user.followed_users).where.not(id: user) }

  def follows?(user)
    followed_users.include?(user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid)
      .or(where(username: auth['info']['nickname'][0..19])).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.fullname = name_from_auth(auth)
      user.username = auth['info']['nickname'][0..19]
    end
  end

  def self.name_from_auth(auth)
    name = auth['info']['name'].empty? ? auth['info']['nickname'] : auth['info']['name']
    name[0..29]
  end
end
