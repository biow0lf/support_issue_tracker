require 'rails_helper'

RSpec.describe UnassignedTicketsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/unassigned_tickets').to route_to('unassigned_tickets#index')
    end
  end
end
