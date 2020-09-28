require 'rails_helper'

RSpec.describe OpinionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/opinions').to route_to('opinions#index')
    end

    it 'routes to #new' do
      expect(get: '/opinions/new').to route_to('opinions#new')
    end
  end
end
