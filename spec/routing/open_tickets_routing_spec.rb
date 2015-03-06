require 'rails_helper'

RSpec.describe OpenTicketsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/open_tickets').to route_to('open_tickets#index')
    end
  end
end
