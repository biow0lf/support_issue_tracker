require 'rails_helper'

RSpec.describe ClosedTicketsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/closed_tickets').to route_to('closed_tickets#index')
    end
  end
end
