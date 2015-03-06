require 'rails_helper'

RSpec.describe OnHoldTicketsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/on_hold_tickets').to route_to('on_hold_tickets#index')
    end
  end
end
