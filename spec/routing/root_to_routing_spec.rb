require 'rails_helper'

RSpec.describe 'root', type: :routing do
  describe 'routing' do
    it 'routes to tickets#new' do
      expect(get: '/').to route_to('tickets#new')
    end
  end
end
