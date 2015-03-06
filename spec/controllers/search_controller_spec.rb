require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    context 'authorized' do
      before(:all) do
        TicketsIndex.purge!
        summary = 'Test summary'
        @ticket1 = create(:ticket, summary: summary)
        @ticket2 = create(:ticket, summary: summary)

        @user = create(:user)
        TicketsIndex.import
      end

      after(:all) do
        Ticket.delete_all
        Status.delete_all
      end

      it 'assigns @tickets as [] on empty search query' do
        sign_in @user
        get :index, q: ''
        expect(assigns(:tickets)).to match_array([])
      end

      it 'assigns @tickets with founded tickets from elasticsearch' do
        sign_in @user
        get :index, q: 'test'
        expect(assigns(:tickets)).to match_array([@ticket1, @ticket2])
      end

      it 'render the :index template' do
        sign_in @user
        get :index
        expect(response).to render_template :index
      end
    end

    context 'not authorized' do
      it 'should redirect to sign in page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
