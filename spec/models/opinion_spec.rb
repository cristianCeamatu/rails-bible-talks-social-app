require 'rails_helper'

RSpec.describe Opinion, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:text) }

    it do
      should validate_length_of(:text).is_at_least(2).is_at_most(500)
    end
  end

  describe 'scopes' do
    before :each do
      @user1 = User.create!(username: 'Marshall', fullname: 'uimarshall@gmail.com')
      @opinion = @user1.opinions.create!(text: 'Example')
    end

    it 'can be created by user' do
      expect(Opinion.first).to eq(@opinion)
    end

    it 'can be accessed by the author' do
      expect(@user1.opinions.first).to eq(@opinion)
    end
  end
end
