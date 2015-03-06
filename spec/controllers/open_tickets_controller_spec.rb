require 'rails_helper'

RSpec.describe OpenTicketsController, type: :controller do
  describe 'GET #index' do
    context 'authorized' do
      before(:all) do
        @status1 = create(:status, name: 'Waiting for Staff Response')
        @status2 = create(:status, name: 'Waiting for Customer')
        @status3 = create(:status, name: 'On Hold')
        create(:status, name: 'Cancelled')
        create(:status, name: 'Completed')
        @ticket1 = create(:ticket, status_id: @status1.id)
        @ticket2 = create(:ticket, status_id: @status2.id)
        @ticket3 = create(:ticket, status_id: @status3.id)
        @user = create(:user)
      end

      after(:all) do
        Ticket.delete_all
        Status.delete_all
      end

      it 'assigns tickets as @tickets' do
        sign_in @user
        get :index
        expect(assigns(:tickets)).to match_array([@ticket1, @ticket2, @ticket3])
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
