require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:opinions) }
    it { should have_many(:followings) }
    it { should have_many(:followed_users) }
    it { should have_many(:followers) }
    it { should have_many(:inverse_followings).class_name('Following') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:fullname) }
    it { should validate_uniqueness_of(:username) }
  end

  describe 'scopes' do
    before :each do
      @user1 = User.create!(username: 'Marshall', fullname: 'uimarshall@gmail.com')
      @user2 = User.create!(username: 'Marshall2', fullname: 'uimarshall2@gmail.com')
      @user3 = User.create!(username: 'Marshall3', fullname: 'uimarshall3@gmail.com')
      @following = @user1.followings.create!(followed_id: @user2.id)
    end

    it 'can be accesed' do
      expect(User.first).to eq(@user1)
    end

    it 'can get all users except one' do
      expect(User.all_except(@user2).to_a).to eq([@user1, @user3])
    end

    it 'can follow an user' do
      expect(@user1.follows?(@user2)).to eq(true)
    end

    it 'can access his followers' do
      expect(@user2.followers.to_a).to eq([@user1])
    end

    it 'can check the users he followed' do
      expect(@user1.followed_users.to_a).to eq([@user2])
    end

    it 'can upload an avatar' do
      file = File.open(Rails.root.join('app', 'assets', 'images', 'placeholder.jpg'))
      attached = @user1.photo.attach(io: file, filename: 'placeholder.jpg', content_type: 'image/jpg')
      expect(attached).to eq(true)
    end

    it 'can upload a cover image' do
      file = File.open(Rails.root.join('app', 'assets', 'images', 'placeholder.jpg'))
      attached = @user1.cover_image.attach(io: file, filename: 'placeholder.jpg', content_type: 'image/jpg')
      expect(attached).to eq(true)
    end
  end
end
