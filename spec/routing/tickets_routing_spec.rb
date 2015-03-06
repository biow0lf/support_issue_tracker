require 'rails_helper'

RSpec.describe TicketsController, type: :routing do
  describe 'routing' do
    before(:all) do
      @id = 'ABC-4F-ABC-8D-ABC'
    end

    it 'routes to #index' do
      expect(get: '/tickets').to route_to('tickets#index')
    end

    it 'routes to #new' do
      expect(get: '/tickets/new').to route_to('tickets#new')
    end

    it 'routes to #show' do
      expect(get: "/tickets/#{ @id }").to route_to('tickets#show', id: @id)
    end

    it 'routes to #edit' do
      expect(get: "/tickets/#{ @id }/edit").to route_to('tickets#edit', id: @id)
    end

    it 'routes to #create' do
      expect(post: '/tickets').to route_to('tickets#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "/tickets/#{ @id }").to route_to('tickets#update', id: @id)
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/tickets/#{ @id }").to route_to('tickets#update', id: @id)
    end

    it 'routes to #destroy' do
      expect(delete: "/tickets/#{ @id }").to route_to('tickets#destroy', id: @id)
    end
  end
end
