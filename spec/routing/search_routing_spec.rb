require 'rails_helper'

RSpec.describe SearchController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/search').to route_to('search#index')
    end

    it 'routes ?q=test to #index' do
      expect(get: '/search?utf=yes&q=test')
        .to route_to('search#index', utf: 'yes', q: 'test')
    end
  end
end
