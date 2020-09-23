require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before :each do
    @user1 = User.create!(username: 'Marshall', fullname: 'uimarshall@gmail.com')
  end

  describe 'POST /create' do
    it 'returns http found' do
      post '/sessions', params: { username: @user1.username }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http found' do
      delete '/sessions/:id'
      expect(response).to have_http_status(:found)
    end
  end
end
