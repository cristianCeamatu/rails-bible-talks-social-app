require 'rails_helper'

RSpec.describe 'Followings', type: :request do
  before(:each) do
    @user1 = User.create!(username: 'Marshall', fullname: 'uimarshall@gmail.com')
    @user2 = User.create!(username: 'Marshall2', fullname: 'uimarshall2@gmail.com')
    @following = @user1.followings.create!(followed_id: @user2.id)
  end

  describe 'POST /followings' do
    it 'returns http 302 found response' do
      post '/sessions', params: { username: @user1.username }
      post '/followings', params: { followed_id: @user2.id }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE /followings' do
    it 'returns http 302 found response' do
      delete '/followings/:id', params: { followed_id: @user2.id }
      expect(response).to have_http_status(:found)
    end
  end
end
