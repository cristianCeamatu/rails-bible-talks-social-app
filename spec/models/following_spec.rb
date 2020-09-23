require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'associations' do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followed).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:follower_id) }
    it { is_expected.to validate_presence_of(:followed_id) }
  end

  describe 'scopes' do
    before :each do
      @user1 = User.create!(username: 'Marshall', fullname: 'uimarshall@gmail.com')
      @user2 = User.create!(username: 'Marshall2', fullname: 'uimarshall2@gmail.com')
      @following = @user1.followings.create!(followed_id: @user2.id)
    end

    it 'can be created by user' do
      expect(Following.first).to eq(@following)
    end

    it 'can be accessed by the follower' do
      expect(@user1.followings.first).to eq(@following)
    end

    it 'can be accessed by the followed with inverse_followings' do
      expect(@user2.inverse_followings.first).to eq(@following)
    end
  end
end
