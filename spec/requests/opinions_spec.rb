require 'rails_helper'

RSpec.describe '/opinions', type: :request do
  let(:valid_attributes) { { text: 'Hello' } }
  let(:invalid_attributes) { { invalid: 'Invalid' } }

  before(:each) do
    @user1 = User.create!(username: 'Marshall', fullname: 'uimarshall@gmail.com')
    post '/sessions', params: { user: { username: @user1.username } }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Opinion' do
        expect do
          post opinions_url, params: { opinion: valid_attributes }
        end.to change(Opinion, :count).by(1)
      end

      it 'redirects to the opinions index' do
        post opinions_url, params: { opinion: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Opinion' do
        expect do
          post opinions_url, params: { opinion: invalid_attributes }
        end.to change(Opinion, :count).by(0)
      end
    end
  end
end
