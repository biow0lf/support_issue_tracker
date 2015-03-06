require 'rails_helper'

RSpec.describe UnassignedTicketsController, type: :controller do
  describe 'GET #index' do
    context 'authorized' do
      before(:all) do
        @ticket1 = create(:ticket)
        @ticket2 = create(:ticket)
        @user = create(:user)
      end

      after(:all) do
        Ticket.delete_all
        Status.delete_all
      end

      it 'assigns tickets as @tickets' do
        sign_in @user
        get :index
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
