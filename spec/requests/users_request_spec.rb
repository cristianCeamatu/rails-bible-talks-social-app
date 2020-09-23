require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before :each do
    @user1 = User.create!(username: 'Marshall', fullname: 'uimarshall@gmail.com')
    post '/sessions', params: { username: @user1.username }
  end

  describe 'GET /sign_up' do
    it 'returns http success' do
      get '/sign_up'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /:id' do
    it 'returns http success' do
      get "/users/#{@user1.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /users' do
    it 'returns http success' do
      post '/users', params: { user: { username: 'User22', fullname: 'User22' } }
      expect(response).to have_http_status(:found)
    end
  end
end
